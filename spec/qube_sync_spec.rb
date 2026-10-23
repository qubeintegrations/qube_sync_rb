# frozen_string_literal: true

RSpec.describe QubeSync do
  # A delivery signed by the QuBe Sync server's own code, with made-up secrets.
  VECTORS = JSON.parse(File.read(File.expand_path("fixtures/webhook_vectors.json", __dir__), encoding: "UTF-8"))
  T = VECTORS["timestamp"]
  BODY = VECTORS["body"]
  SECRET_ONE, SECRET_TWO = VECTORS["secrets"]

  before do
    ENV["QUBE_API_KEY"] = "test"
    ENV["QUBE_WEBHOOK_SECRET"] = SECRET_ONE
    allow(Time).to receive(:now).and_return(Time.at(T))
  end

  def verify(body = BODY, header = VECTORS["header_one_secret"], **opts)
    QubeSync.verify_and_build_webhook!(body, header, **opts)
  end

  it "has a version number" do
    expect(QubeSync::VERSION).to eq("0.3.0")
  end

  describe "#verify_and_build_webhook!" do
    it "verifies a delivery signed by the server and returns the parsed body" do
      expect(verify).to eq(JSON.parse(BODY))
      expect(verify["response_json"]["note"]).to eq("naïve café — ünïcode")
    end

    it "verifies a delivery signed with two secrets while a secret rotates, with either one" do
      expect(verify(BODY, VECTORS["header_two_secrets"])).to eq(JSON.parse(BODY))

      ENV["QUBE_WEBHOOK_SECRET"] = SECRET_TWO
      expect(verify(BODY, VECTORS["header_two_secrets"])).to eq(JSON.parse(BODY))
      expect { verify(BODY, VECTORS["header_one_secret"]) }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "verifies a body read as binary" do
      expect(verify(BODY.dup.force_encoding(Encoding::BINARY))).to eq(JSON.parse(BODY))
    end

    it "refuses the wrong secret" do
      ENV["QUBE_WEBHOOK_SECRET"] = "whsec_some_other_secret"
      expect { verify }.to raise_error(QubeSync::InvalidWebhookSignatureError, "Webhook signature mismatch")
    end

    it "refuses a tampered body" do
      expect { verify(BODY.sub("processed", "cancelled")) }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "refuses a re-serialized body" do
      expect { verify(JSON.generate(JSON.parse(BODY)).sub("{", "{ ")) }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "refuses the HMAC of the body alone, without the timestamp" do
      body_only = OpenSSL::HMAC.hexdigest("sha256", SECRET_ONE, BODY)
      expect { verify(BODY, "t=#{T},v1=#{body_only}") }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "refuses a header with no v1 signature, or a blank one" do
      expect { verify(BODY, "t=#{T}") }.to raise_error(QubeSync::InvalidWebhookSignatureError)
      expect { verify(BODY, "t=#{T},v1=") }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "refuses a signature under another scheme" do
      v1 = VECTORS["header_one_secret"].split("v1=").last
      expect { verify(BODY, "t=#{T},v0=#{v1}") }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "refuses a malformed or missing header" do
      [nil, "", "garbage", "v1=abc", "t=abc,v1=abc", "t=,v1=abc"].each do |header|
        expect { verify(BODY, header) }.to raise_error(QubeSync::InvalidWebhookSignatureError), "header #{header.inspect}"
      end
    end

    it "finds t and v1 by key, in any order" do
      v1 = VECTORS["header_one_secret"].split("v1=").last
      expect(verify(BODY, "v1=#{v1},t=#{T}")).to eq(JSON.parse(BODY))
    end

    it "compares signatures in constant time" do
      expect(QubeSync).to receive(:secure_compare).at_least(:once).and_call_original
      verify
    end

    describe "the timestamp window" do
      def at(now)
        allow(Time).to receive(:now).and_return(Time.at(now))
      end

      it "accepts a delivery up to 300 seconds old" do
        at(T + 300)
        expect(verify).to eq(JSON.parse(BODY))
      end

      it "refuses a delivery 301 seconds old" do
        at(T + 301)
        expect { verify }.to raise_error(QubeSync::StaleWebhookError, /301 seconds old/)
      end

      it "accepts a timestamp up to 300 seconds in the future" do
        at(T - 300)
        expect(verify).to eq(JSON.parse(BODY))
      end

      it "refuses a timestamp 301 seconds in the future" do
        at(T - 301)
        expect { verify }.to raise_error(QubeSync::StaleWebhookError, /301 seconds in the future/)
      end

      it "takes another window with max_age, both ways" do
        at(T + 120)
        expect { verify(max_age: 60) }.to raise_error(QubeSync::StaleWebhookError)
        at(T - 120)
        expect { verify(max_age: 60) }.to raise_error(QubeSync::StaleWebhookError)
        expect(verify(max_age: 120)).to eq(JSON.parse(BODY))
      end

      it "checks the window before the signature" do
        at(T + 301)
        expect { verify(BODY, "t=#{T},v1=bad") }.to raise_error(QubeSync::StaleWebhookError)
      end
    end
  end

  describe "#secure_compare" do
    it "is true only for equal strings" do
      expect(QubeSync.secure_compare("abc", "abc")).to be(true)
      expect(QubeSync.secure_compare("abc", "abd")).to be(false)
      expect(QubeSync.secure_compare("abc", "abcd")).to be(false)
      expect(QubeSync.secure_compare("", "")).to be(true)
    end
  end
end
