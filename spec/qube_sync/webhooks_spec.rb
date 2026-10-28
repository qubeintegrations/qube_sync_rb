# frozen_string_literal: true

RSpec.describe QubeSync::Webhooks do
  # Test vectors from the QuBe Sync server (mix webhook_vectors.gen): real bodies and headers,
  # made-up ids, timestamp and secrets.
  vectors = JSON.parse(File.read(File.expand_path("../fixtures/test_vectors.json", __dir__), encoding: "UTF-8"))

  let(:vectors) { vectors }
  let(:t) { vectors["timestamp"] }
  let(:secret) { vectors["secrets"].first }
  let(:event_case) { vectors["events"].find { |c| c["name"] == "workflow_run.completed" } }
  let(:body) { event_case["body"] }
  let(:header) { event_case["header"] }

  def sign(body, secret, t)
    "t=#{t},v1=#{OpenSSL::HMAC.hexdigest("sha256", secret, "#{t}.#{body}")}"
  end

  describe "signature vectors" do
    vectors["signatures"].each do |c|
      it c["name"] do
        verify = lambda do
          described_class.verify(c["body"], c["header"], secrets: c["secrets"], tolerance: c["tolerance"], now: c["now"])
        end

        if c["valid"]
          expect(verify.call.to_h).to eq(JSON.parse(c["body"]))
        else
          expect(&verify).to raise_error(QubeSync::Webhooks::SignatureError) { |e| expect(e.reason).to eq(c["reason"].to_sym) }
        end
      end
    end
  end

  describe "event vectors" do
    vectors["events"].each do |c|
      it c["name"] do
        event = described_class.verify(c["body"], c["header"], secrets: vectors["secrets"].first, now: vectors["timestamp"])

        c["expect"].each do |field, value|
          expect(event.public_send(field)).to eq(value), "#{field}: expected #{value.inspect}, got #{event.public_send(field).inspect}"
        end
        expect(event.to_h).to eq(JSON.parse(c["body"]))
        expect(described_class.parse(c["body"])).to eq(event)
      end
    end
  end

  describe ".verify" do
    it "takes a single secret as a String" do
      expect(described_class.verify(body, header, secrets: secret, now: t)).to be_a(QubeSync::Webhooks::WorkflowRunEvent)
    end

    it "refuses an empty list of secrets as a programming mistake, not a bad signature" do
      expect { described_class.verify(body, header, secrets: [], now: t) }.to raise_error(ArgumentError, /secrets/)
      expect { described_class.verify(body, header, secrets: nil, now: t) }.to raise_error(ArgumentError)
      expect { described_class.verify(body, header, secrets: [""], now: t) }.to raise_error(ArgumentError)
    end

    it "refuses a parsed body and says to pass the raw one" do
      expect { described_class.verify(JSON.parse(body), header, secrets: secret, now: t) }
        .to raise_error(TypeError, /raw request body/)
      expect { described_class.parse(JSON.parse(body)) }.to raise_error(TypeError, /raw request body/)
    end

    it "takes now as a Time" do
      expect(described_class.verify(body, header, secrets: secret, now: Time.at(t + 300))).to be_a(QubeSync::Webhooks::Event)
      expect { described_class.verify(body, header, secrets: secret, now: Time.at(t + 301)) }
        .to raise_error(QubeSync::Webhooks::SignatureError) { |e| expect(e.reason).to eq(:stale) }
    end

    it "defaults now to the current time" do
      allow(Time).to receive(:now).and_return(Time.at(t + 10))
      expect(described_class.verify(body, header, secrets: secret)).to be_a(QubeSync::Webhooks::Event)

      allow(Time).to receive(:now).and_return(Time.at(t + 1000))
      expect { described_class.verify(body, header, secrets: secret) }.to raise_error(QubeSync::Webhooks::SignatureError)
    end

    it "verifies a body read as binary, as Rack hands it over" do
      request = vectors["events"].first
      event = described_class.verify(request["body"].b, request["header"].b, secrets: secret, now: t)
      expect(event.response_json.dig("data", "notes")).to eq("Naïve café — ünïcode, kept as UTF-8")
    end

    it "says how stale a timestamp is" do
      expect { described_class.verify(body, header, secrets: secret, now: t + 400) }
        .to raise_error(QubeSync::Webhooks::SignatureError, /400 seconds old; it must be within 300 seconds/)
      expect { described_class.verify(body, header, secrets: secret, now: t - 400) }
        .to raise_error(QubeSync::Webhooks::SignatureError, /400 seconds in the future/)
    end

    it "raises an error that is a QubeSync::Error with the reason as a Symbol" do
      expect { described_class.verify(body, nil, secrets: secret, now: t) }
        .to raise_error(QubeSync::Error) { |e| expect(e.reason).to eq(:missing) }
    end

    it "never puts the secret, a signature or the body in an error message" do
      signature = header[/v1=(\h+)/, 1]
      failures = [
        [body, nil, t, :missing],
        [body, "t=soon,v1=#{signature}", t, :malformed],
        [body, header, t + 1000, :stale],
        [body, "t=#{t},v1=#{"0" * 64}", t, :mismatch],
        [body.sub("completed", "failed"), header, t, :mismatch]
      ]

      messages = failures.map do |raw, h, now, reason|
        described_class.verify(raw, h, secrets: secret, now: now)
        raise "expected #{reason} to fail"
      rescue QubeSync::Webhooks::SignatureError => e
        expect(e.reason).to eq(reason)
        e.message + e.inspect + e.full_message
      end

      messages.each do |message|
        expect(message).not_to include(secret)
        expect(message).not_to include(signature)
        expect(message).not_to include("0" * 64)
        expect(message).not_to include("Riverbend")
      end
    end

    it "raises a ParseError, without the body, for a signed body that isn't a JSON object" do
      ["not json Riverbend", "[1,2]"].each do |raw|
        expect { described_class.verify(raw, sign(raw, secret, t), secrets: secret, now: t) }
          .to raise_error(QubeSync::Webhooks::ParseError) { |e| expect(e.message).not_to include("Riverbend") }
      end
    end

    it "leaves verify_and_build_webhook! as it was" do
      ENV["QUBE_WEBHOOK_SECRET"] = secret
      allow(Time).to receive(:now).and_return(Time.at(t))
      expect(QubeSync.verify_and_build_webhook!(body, header)).to eq(JSON.parse(body))
    end
  end

  describe "events" do
    def parse(hash)
      described_class.parse(JSON.generate(hash))
    end

    it "reads missing keys as nil" do
      events = [
        parse("page_request_id" => "p1"),
        parse("event" => "workflow_run.completed"),
        parse("event" => "workflow_run.notification"),
        parse("event" => "connection.stalled"),
        parse("event" => "name_index.ready"),
        parse({})
      ]
      expect(events.map(&:type)).to eq(%w[request workflow_run notification connection name_index unknown])

      accessors = %i[
        id page_request_id state page iteration_state response_json error run_id reference revision run_state
        workflow connection_id prompt outcome output summary cancel_reason links delivery_id seq name from data
        connection stall_reason name_index timestamp app_id sandbox
      ]
      events.each do |event|
        accessors.select { |a| event.respond_to?(a) }.each do |accessor|
          next if event.type == "request" && %i[page_request_id].include?(accessor)

          expect(event.public_send(accessor)).to be_nil, "#{event.type}.#{accessor}"
        end
        expect(event["anything"]).to be_nil
      end
      expect(events.first.dedupe_key).to eq("p1:")
    end

    it "reads connection_id and stall_reason off the connection object" do
      stalled = vectors["events"].find { |c| c["name"] == "connection.stalled" }
      event = described_class.parse(stalled["body"])
      expect(event.connection_id).to eq("0196a1c0-0000-7000-8000-00000000c001")
      expect(event.stall_reason).to eq("not_checking_in")
      expect(event).to be_stalled
      expect(parse("event" => "connection.stalled", "connection" => "not an object").connection_id).to be_nil
    end

    it "compares revisions with newer_than?" do
      event = described_class.parse(body) # revision 9
      expect(event.newer_than?(nil)).to be(true)
      expect(event.newer_than?(8)).to be(true)
      expect(event.newer_than?(9)).to be(false)
      expect(event.newer_than?(10)).to be(false)
      expect(parse("event" => "workflow_run.completed").newer_than?(1)).to be(false)
    end

    it "has newer_than? on workflow runs and connections, never on notifications" do
      types = vectors["events"].map { |c| described_class.parse(c["body"]) }.group_by(&:type)
      expect(types["workflow_run"]).to all(respond_to(:newer_than?))
      expect(types["connection"]).to all(respond_to(:newer_than?))
      expect(types["notification"].first).not_to respond_to(:newer_than?)
    end

    it "answers predicates for the workflow run's event" do
      expect(described_class.parse(body)).to be_completed
      expect(described_class.parse(body)).not_to be_awaiting_input
    end

    it "keeps an event this library doesn't know, including a new workflow_run event" do
      event = parse("event" => "workflow_run.paused", "revision" => 3, "reference" => "r", "delivery_id" => "d")
      expect(event).to be_a(QubeSync::Webhooks::UnknownEvent)
      expect([event.type, event.event, event.dedupe_key, event.revision, event.reference]).to eq(["unknown", "workflow_run.paused", nil, nil, nil])
      expect(event["revision"]).to eq(3)
      expect(event.to_h).to include("delivery_id" => "d")
    end

    describe "request answers QuickBooks may have applied" do
      def request_event(state, error_type = nil)
        body = {"id" => "q1", "page_request_id" => "q1", "state" => state}
        body["error"] = {"error_type" => error_type, "user_message" => "Check QuickBooks."} if error_type
        parse(body)
      end

      it "is perhaps_applied? for timed_out and for an outcome_unknown error" do
        expect(request_event("timed_out", "timed_out")).to be_perhaps_applied
        expect(request_event("timed_out")).to be_perhaps_applied
        expect(request_event("error", "outcome_unknown")).to be_perhaps_applied
        expect(request_event("error", "outcome_unknown").error_type).to eq("outcome_unknown")
      end

      it "isn't for other errors or answers" do
        expect(request_event("error", "unexpected_error")).not_to be_perhaps_applied
        expect(request_event("retryable", "retryable")).not_to be_perhaps_applied
        expect(request_event("response_received")).not_to be_perhaps_applied
        expect(request_event("response_received").error_type).to be_nil
        expect(parse({"page_request_id" => "q1", "error" => "text"}).error_type).to be_nil
      end
    end

    describe "a request answer over 1 MB" do
      let(:link) { "https://qubesync.com/api/v2/connections/c1/queued-requests/q1" }

      it "comes without response_xml, with response_xml_omitted and links.self" do
        event = parse({"page_request_id" => "q1", "state" => "response_received", "response_xml" => nil,
                       "response_xml_omitted" => true, "links" => {"self" => link},
                       "response_json" => {"customers" => []}})
        expect(event).to be_response_xml_omitted
        expect(event.response_xml).to be_nil
        expect(event.self_link).to eq(link)
        expect(event.response_json).to eq({"customers" => []})
      end

      it "otherwise carries response_xml and no self link" do
        event = parse({"page_request_id" => "q1", "state" => "response_received", "response_xml" => "<QBXML/>"})
        expect(event).not_to be_response_xml_omitted
        expect(event.response_xml).to eq("<QBXML/>")
        expect(event.self_link).to be_nil
      end
    end

    it "builds from JSON with Event.from_json" do
      expect(QubeSync::Webhooks::Event.from_json(body)).to eq(described_class.parse(body))
    end
  end
end
