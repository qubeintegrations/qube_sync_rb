# frozen_string_literal: true

require "rbconfig"
require "socket"

# A real HTTP server on a local socket, one thread per connection. Each request is recorded, and
# answered by the next queued responder (or 200 `{"data": {}}` when none is left). A responder is
# `[status, headers, body]`, `:reset` (close the socket without answering), or a lambda taking
# the recorded request and returning either.
class FakeQubeServer
  Request = Struct.new(:method, :path, :query, :headers, :body, keyword_init: true) do
    def json
      JSON.parse(body)
    end

    def query_pairs
      URI.decode_www_form(query.to_s)
    end

    def query_hash
      query_pairs.to_h
    end
  end

  attr_reader :requests, :port

  def initialize(port = 0)
    @server = TCPServer.new("127.0.0.1", port)
    @port = @server.addr[1]
    @requests = Queue.new
    @recorded = []
    @responders = Queue.new
    @lock = Mutex.new
    @threads = []
    @acceptor = Thread.new { accept_loop }
  end

  def url
    "http://127.0.0.1:#{port}"
  end

  def respond(*responders)
    responders.each { |r| @responders << r }
    self
  end

  def recorded
    @lock.synchronize { @recorded.dup }
  end

  def last
    recorded.last
  end

  def stop
    @server.close
    @acceptor.kill
    @threads.each(&:kill)
  end

  private

  def accept_loop
    loop do
      socket = @server.accept
      @threads << Thread.new(socket) { |s| handle(s) }
    end
  rescue IOError, Errno::EBADF
    nil
  end

  def handle(socket)
    request_line = socket.gets or return socket.close
    method, target, = request_line.split(" ")
    headers = {}
    while (line = socket.gets) && line != "\r\n"
      name, value = line.split(":", 2)
      headers[name.strip.downcase] = value.strip
    end
    length = headers["content-length"].to_i
    body = length.positive? ? socket.read(length) : ""
    path, query = target.split("?", 2)
    request = Request.new(method: method, path: path, query: query, headers: headers, body: body)
    @lock.synchronize { @recorded << request }

    responder = @responders.empty? ? [200, {}, '{"data":{}}'] : @responders.pop
    responder = responder.call(request) if responder.respond_to?(:call)

    if responder == :reset
      socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_LINGER, [1, 0].pack("ii"))
      socket.close
      return
    end

    status, extra_headers, response_body = responder
    response_body = response_body.to_s
    head = +"HTTP/1.1 #{status} Answer\r\n"
    head << "Content-Length: #{response_body.bytesize}\r\n"
    head << "Connection: close\r\n"
    extra_headers.each { |name, value| head << "#{name}: #{value}\r\n" }
    head << "\r\n"
    socket.write(head)
    socket.write(response_body)
    socket.close
  rescue IOError, SystemCallError
    nil
  end
end

RSpec.describe QubeSync::Client do
  let(:server) { FakeQubeServer.new }
  let(:sleeps) { [] }
  let(:api_key) { "sk_test_secret_key_123" }
  let(:client) { described_class.new(api_key: api_key, base_url: server.url, sleep: ->(s) { sleeps << s }) }

  after { server.stop }

  def json(status, value, headers = {})
    [status, {"Content-Type" => "application/json"}.merge(headers), JSON.generate(value)]
  end

  def data(value, status = 200)
    json(status, {"data" => value})
  end

  describe "construction" do
    it "requires an api key" do
      expect { described_class.new(api_key: nil) }.to raise_error(ArgumentError)
      expect { described_class.new(api_key: " ") }.to raise_error(ArgumentError)
    end

    it "defaults to qubesync.com and strips trailing slashes" do
      expect(described_class.new(api_key: api_key).base_url).to eq("https://qubesync.com")
      expect(described_class.new(api_key: api_key, base_url: "https://example.test//").base_url).to eq("https://example.test")
    end

    it "has the default timeouts and retries" do
      c = described_class.new(api_key: api_key)
      expect([c.open_timeout, c.read_timeout, c.max_retries, c.total_timeout]).to eq([5, 30, 2, 60])
    end

    it "never shows the key in inspect, to_s or pp" do
      expect(client.inspect).to eq("#<QubeSync::Client base_url=#{server.url}>")
      expect(client.to_s).not_to include(api_key)
      require "pp"
      expect(client.pretty_inspect).not_to include(api_key)
      expect(client.inspect).not_to include(["#{api_key}:"].pack("m0"))
    end

    it "loads on its own, without Faraday or the v1 functions" do
      lib = File.expand_path("../../lib", __dir__)
      script = 'require "qube_sync/client"; abort "faraday" if defined?(Faraday); ' \
        'abort "v1" if QubeSync.respond_to?(:create_connection); ' \
        'abort "error" unless QubeSync::APIError.superclass == QubeSync::Error; ' \
        'require "qube_sync/webhooks"; require "qube_sync"; puts QubeSync::Client.name'
      output = IO.popen([RbConfig.ruby, "-I", lib, "-e", script], err: File::NULL, &:read)
      expect(output.strip).to eq("QubeSync::Client")
      expect($?.success?).to be(true)
    end
  end

  describe "requests" do
    it "sends Basic auth, Accept and User-Agent, with no Content-Type without a body" do
      server.respond(data([]))
      client.list_connections
      request = server.last
      expect(request.headers["authorization"]).to eq("Basic #{["#{api_key}:"].pack("m0")}")
      expect(request.headers["accept"]).to eq("application/json")
      expect(request.headers["user-agent"]).to eq("qube_sync-ruby/#{QubeSync::VERSION}")
      expect(request.headers).not_to have_key("content-type")
      expect(request.path).to eq("/api/v2/connections")
    end

    it "unwraps data" do
      server.respond(data([{"id" => "c1"}]))
      expect(client.list_connections).to eq([{"id" => "c1"}])
    end

    it "returns nil for a 204" do
      server.respond([204, {}, ""])
      expect(client.delete_connection("c1")).to be_nil
      expect(server.last.method).to eq("DELETE")
      expect(server.last.path).to eq("/api/v2/connections/c1")
    end
  end

  describe "connections" do
    it "create_connection posts webhook_url and name, omitting nil" do
      server.respond(data({"id" => "c1"}, 201), data({"id" => "c2"}, 201))
      expect(client.create_connection(webhook_url: "https://app.test/hook", name: "Acme")).to eq({"id" => "c1"})
      expect(server.last.method).to eq("POST")
      expect(server.last.path).to eq("/api/v2/connections")
      expect(server.last.headers["content-type"]).to eq("application/json")
      expect(server.last.json).to eq({"webhook_url" => "https://app.test/hook", "name" => "Acme"})

      client.create_connection(webhook_url: "https://app.test/hook")
      expect(server.last.json).to eq({"webhook_url" => "https://app.test/hook"})
      expect(server.last.headers).not_to have_key("idempotency-key")
    end

    it "get_connection" do
      server.respond(data({"id" => "c1"}))
      expect(client.get_connection("c1")).to eq({"id" => "c1"})
      expect([server.last.method, server.last.path]).to eq(["GET", "/api/v2/connections/c1"])
    end

    it "update_connection puts only the given keys" do
      server.respond(data({"id" => "c1"}))
      client.update_connection("c1", name: "New")
      expect([server.last.method, server.last.path]).to eq(["PUT", "/api/v2/connections/c1"])
      expect(server.last.json).to eq({"name" => "New"})
    end

    it "regenerate_onboarding" do
      server.respond(data({"id" => "c1", "links" => {"onboarding" => "https://x"}}))
      expect(client.regenerate_onboarding("c1")["links"]).to eq({"onboarding" => "https://x"})
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/onboarding-url"])
      expect(server.last.body).to eq("")
    end

    it "set_password with and without a password" do
      server.respond(data({"id" => "c1", "password" => "pw"}), data({"id" => "c1", "password" => "gen"}))
      expect(client.set_password("c1", password: "pw")).to eq({"id" => "c1", "password" => "pw"})
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/password"])
      expect(server.last.json).to eq({"password" => "pw"})

      client.set_password("c1")
      expect(server.last.body).to eq("")
      expect(server.last.headers).not_to have_key("content-type")
    end

    it "get_qwc returns the XML string" do
      server.respond(json(200, {"qwc" => "<QBWCXML/>"}))
      expect(client.get_qwc("c1")).to eq("<QBWCXML/>")
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/qwc"])
    end

    it "escapes ids in paths" do
      server.respond(data({}))
      client.get_connection("a b/c")
      expect(server.last.path).to eq("/api/v2/connections/a%20b%2Fc")
      expect { client.get_connection("..") }.to raise_error(ArgumentError)
      expect { client.get_connection("") }.to raise_error(ArgumentError)
    end
  end

  describe "runs" do
    it "start_run sends the reference as the Idempotency-Key" do
      server.respond(data({"id" => "r1"}, 201))
      result = client.start_run("c1", "sync_customer", {"customer" => {"name" => "Acme"}},
        reference: "order-42", webhook_url: "https://app.test/runs", version: 3)
      expect(result).to eq({"id" => "r1"})
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/workflow-runs"])
      expect(server.last.headers["idempotency-key"]).to eq("order-42")
      expect(server.last.json).to eq({
        "workflow" => "sync_customer", "reference" => "order-42",
        "input" => {"customer" => {"name" => "Acme"}}, "webhook_url" => "https://app.test/runs", "version" => 3
      })
    end

    it "start_run omits a nil version and is retried" do
      server.respond([503, {}, ""], data({"id" => "r1"}, 201))
      client.start_run("c1", "w", {}, reference: "ref", webhook_url: "https://app.test/runs")
      expect(server.recorded.size).to eq(2)
      expect(server.recorded.map { |r| r.headers["idempotency-key"] }).to eq(["ref", "ref"])
      expect(server.last.json).not_to have_key("version")
    end

    it "get_run takes a link or ids" do
      server.respond(data({"id" => "r1"}), data({"id" => "r1"}))
      client.get_run("#{server.url}/api/v2/connections/c1/workflow-runs/r1")
      expect(server.last.path).to eq("/api/v2/connections/c1/workflow-runs/r1")
      client.get_run("c1", "r1")
      expect([server.last.method, server.last.path]).to eq(["GET", "/api/v2/connections/c1/workflow-runs/r1"])
    end

    it "list_runs drops nil filters" do
      server.respond(data([]), data([]))
      client.list_runs("c1", reference: "order-42", state: "awaiting_input")
      expect(server.last.path).to eq("/api/v2/connections/c1/workflow-runs")
      expect(server.last.query_hash).to eq({"reference" => "order-42", "state" => "awaiting_input"})
      client.list_runs("c1")
      expect(server.last.query).to be_nil
    end

    it "cancel_run posts the reason or {}" do
      server.respond(data({"id" => "r1"}), data({"id" => "r1"}))
      link = "#{server.url}/api/v2/connections/c1/workflow-runs/r1/cancel"
      client.cancel_run(link, reason: "changed my mind")
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/workflow-runs/r1/cancel"])
      expect(server.last.json).to eq({"reason" => "changed my mind"})
      client.cancel_run(link)
      expect(server.last.json).to eq({})
    end

    it "run_events returns the whole body" do
      body = {"data" => [{"seq" => 1}], "next_after" => 1}
      server.respond(json(200, body))
      expect(client.run_events("c1", "r1", after: 0, limit: 50)).to eq(body)
      expect(server.last.path).to eq("/api/v2/connections/c1/workflow-runs/r1/events")
      expect(server.last.query_hash).to eq({"after" => "0", "limit" => "50"})
    end
  end

  describe "questions" do
    let(:decisions) { "#{server.url}/api/v2/connections/c1/workflow-runs/r1/decisions?prompt_token=tok" }
    let(:search_link) { "#{server.url}/api/v2/connections/c1/workflow-runs/r1/search?prompt_token=tok" }

    it "answer posts the choice and data, keeping the link's query" do
      server.respond(data({"id" => "r1"}), data({"id" => "r1"}))
      client.answer(decisions, choice: "rename", data: {"name" => "Acme 2"})
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/workflow-runs/r1/decisions"])
      expect(server.last.query).to eq("prompt_token=tok")
      expect(server.last.json).to eq({"choice" => "rename", "data" => {"name" => "Acme 2"}})
      expect(server.last.headers).not_to have_key("idempotency-key")

      client.answer(decisions, choice: "skip")
      expect(server.last.json).to eq({"choice" => "skip"})
    end

    it "search appends field and q after the link's query and returns the array" do
      server.respond(data([{"id" => "80000001"}]))
      expect(client.search(search_link, field: "customer", q: "Ac me")).to eq([{"id" => "80000001"}])
      expect(server.last.method).to eq("GET")
      expect(server.last.query_pairs).to eq([["prompt_token", "tok"], ["field", "customer"], ["q", "Ac me"]])
      expect(server.last.query).to start_with("prompt_token=tok&")
    end
  end

  describe "links" do
    it "refuses another host, port or scheme before any request" do
      other_port = server.port == 65_535 ? 1 : server.port + 1
      [
        "http://evil.test:#{server.port}/api/v2/connections/c1/workflow-runs/r1",
        "http://127.0.0.1:#{other_port}/api/v2/connections/c1/workflow-runs/r1",
        "https://127.0.0.1:#{server.port}/api/v2/connections/c1/workflow-runs/r1"
      ].each do |link|
        expect { client.get_run(link) }.to raise_error(ArgumentError) { |e|
          expect(e.message).to include("127.0.0.1:#{server.port}")
          expect(e.message).not_to include(api_key)
        }
      end
      expect { client.answer("ftp://127.0.0.1/x", choice: "a") }.to raise_error(ArgumentError)
      expect { client.cancel_run("connections/c1") }.to raise_error(ArgumentError)
      expect(server.recorded).to be_empty
    end

    it "accepts a link on the same origin, case aside" do
      server.respond(data({}))
      client.get_run("HTTP://127.0.0.1:#{server.port}/api/v2/connections/c1/workflow-runs/r1")
      expect(server.recorded.size).to eq(1)
    end
  end

  describe "queued requests" do
    it "queue posts params as the body with webhook_url in the query and a fresh UUID key" do
      server.respond(data({"id" => "q1"}, 201))
      expect(client.queue("c1", "/customers", {name: "Acme"}, webhook_url: "https://app.test/qb")).to eq({"id" => "q1"})
      request = server.last
      expect([request.method, request.path]).to eq(["POST", "/api/v2/connections/c1/customers"])
      expect(request.query_hash).to eq({"webhook_url" => "https://app.test/qb"})
      expect(request.json).to eq({"name" => "Acme"})
      expect(request.headers["idempotency-key"]).to match(/\A\h{8}-\h{4}-4\h{3}-[89ab]\h{3}-\h{12}\z/)
    end

    it "queue reuses its generated key on a retry, and makes a new one per call" do
      server.respond([502, {}, "Bad Gateway"], data({"id" => "q1"}, 201), data({"id" => "q2"}, 201))
      client.queue("c1", "invoices", {}, webhook_url: "https://app.test/qb")
      client.queue("c1", "invoices", {}, webhook_url: "https://app.test/qb")
      keys = server.recorded.map { |r| r.headers["idempotency-key"] }
      expect(keys[0]).to eq(keys[1])
      expect(keys[2]).not_to eq(keys[0])
    end

    it "queue with method: :get sends params in the query, arrays repeated" do
      server.respond(data({"id" => "q1"}, 201))
      client.queue("c1", "customers", {max_returned: 10, list_id: %w[1 2], active_status: nil},
        webhook_url: "https://app.test/qb", method: :get, idempotency_key: "k1")
      request = server.last
      expect([request.method, request.path, request.body]).to eq(["GET", "/api/v2/connections/c1/customers", ""])
      expect(request.query_pairs).to eq([["max_returned", "10"], ["list_id", "1"], ["list_id", "2"], ["webhook_url", "https://app.test/qb"]])
      expect(request.headers["idempotency-key"]).to eq("k1")
    end

    it "queue refuses a Hash in a query and an unknown method" do
      expect { client.queue("c1", "customers", {name_range: {from: "a"}}, webhook_url: "x", method: :get) }.to raise_error(ArgumentError)
      expect { client.queue("c1", "customers", {}, webhook_url: "x", method: :patch) }.to raise_error(ArgumentError)
      expect(server.recorded).to be_empty
    end

    it "queue with :put and :delete" do
      server.respond(data({}), data({}))
      client.queue("c1", "customers", {list_id: "1", name: "B"}, webhook_url: "w", method: :put)
      expect([server.last.method, server.last.json]).to eq(["PUT", {"list_id" => "1", "name" => "B"}])
      client.queue("c1", "txn-deleteds", {txn_del_type: "Invoice"}, webhook_url: "w", method: :delete)
      expect([server.last.method, server.last.path]).to eq(["DELETE", "/api/v2/connections/c1/txn-deleteds"])
      expect(server.last.query_hash).to eq({"txn_del_type" => "Invoice", "webhook_url" => "w"})
    end

    it "queue_qbxml posts request_xml with webhook_url in the query" do
      server.respond(data({"id" => "q1"}, 201))
      client.queue_qbxml("c1", "<QBXML/>", webhook_url: "https://app.test/qb", idempotency_key: "k2")
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/queued-requests"])
      expect(server.last.json).to eq({"request_xml" => "<QBXML/>"})
      expect(server.last.query_hash).to eq({"webhook_url" => "https://app.test/qb"})
      expect(server.last.headers["idempotency-key"]).to eq("k2")
    end

    it "get_request, request_pages and discard_request" do
      server.respond(data({"id" => "q1"}), data([{"page" => 1}]), data({"id" => "q1", "state" => "discarded"}))
      expect(client.get_request("c1", "q1")).to eq({"id" => "q1"})
      expect([server.last.method, server.last.path]).to eq(["GET", "/api/v2/connections/c1/queued-requests/q1"])
      expect(client.request_pages("c1", "q1")).to eq([{"page" => 1}])
      expect(server.last.path).to eq("/api/v2/connections/c1/queued-requests/q1/pages")
      client.discard_request("c1", "q1")
      expect([server.last.method, server.last.path]).to eq(["POST", "/api/v2/connections/c1/queued-requests/q1/discard"])
    end

    it "list_requests returns the whole body" do
      body = {"data" => [{"id" => "q1"}], "meta" => {"page" => 2, "total_pages" => 3}}
      server.respond(json(200, body))
      expect(client.list_requests("c1", page: 2, page_size: 50, state: "waiting", sort_direction: "desc")).to eq(body)
      expect(server.last.query_hash).to eq({"page" => "2", "page_size" => "50", "state" => "waiting", "sort_direction" => "desc"})
    end

    it "each_request walks every page, as an Enumerator without a block" do
      server.respond(
        json(200, {"data" => [{"id" => "a"}, {"id" => "b"}], "meta" => {"page" => 1, "total_pages" => 3}}),
        json(200, {"data" => [{"id" => "c"}], "meta" => {"page" => 2, "total_pages" => 3}}),
        json(200, {"data" => [{"id" => "d"}], "meta" => {"page" => 3, "total_pages" => 3}})
      )
      enum = client.each_request("c1", state: "waiting")
      expect(enum).to be_a(Enumerator)
      expect(enum.map { |r| r["id"] }).to eq(%w[a b c d])
      expect(server.recorded.map(&:query_hash)).to eq([1, 2, 3].map { |p| {"page" => p.to_s, "state" => "waiting"} })
    end

    it "each_request stops on an empty page" do
      server.respond(json(200, {"data" => [], "meta" => {"page" => 1, "total_pages" => 5}}))
      ids = []
      client.each_request("c1") { |r| ids << r["id"] }
      expect(ids).to be_empty
      expect(server.recorded.size).to eq(1)
    end
  end

  describe "request" do
    it "returns the whole body, and nil for an empty one" do
      server.respond(json(200, {"data" => [1], "meta" => {}}), [200, {}, ""])
      expect(client.request(:get, "/workflows", query: {a: 1}, headers: {"X-Extra" => "yes"})).to eq({"data" => [1], "meta" => {}})
      expect(server.last.path).to eq("/api/v2/workflows")
      expect(server.last.query).to eq("a=1")
      expect(server.last.headers["x-extra"]).to eq("yes")
      expect(client.request(:post, "/workflows/validate", {definition: {}})).to be_nil
      expect(server.last.json).to eq({"definition" => {}})
    end

    it "never lets a header replace the Authorization" do
      server.respond(data({}))
      client.request(:get, "/connections", headers: {"authorization" => "Basic other"})
      expect(server.last.headers["authorization"]).to eq("Basic #{["#{api_key}:"].pack("m0")}")
    end
  end

  describe "retries" do
    [502, 503, 504, 429].each do |status|
      it "retries a GET on #{status}" do
        server.respond([status, {}, ""], [status, {}, ""], data([{"id" => "c1"}]))
        expect(client.list_connections).to eq([{"id" => "c1"}])
        expect(server.recorded.size).to eq(3)
        expect(sleeps.size).to eq(2)
        expect(sleeps[0]).to be_between(0.5, 0.625)
        expect(sleeps[1]).to be_between(1.0, 1.25)
      end
    end

    it "raises APIError after the last try" do
      server.respond([503, {}, ""], [503, {}, ""], [503, {}, ""])
      expect { client.get_connection("c1") }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(503) }
      expect(server.recorded.size).to eq(3)
    end

    it "honours Retry-After on 429 and 503, capped at 30 seconds" do
      server.respond([429, {"Retry-After" => "7"}, ""], [503, {"Retry-After" => "120"}, ""], data([]))
      client.list_connections
      expect(sleeps).to eq([7.0, 30])
    end

    it "ignores Retry-After on a 502" do
      server.respond([502, {"Retry-After" => "7"}, ""], data([]))
      client.list_connections
      expect(sleeps.first).to be_between(0.5, 0.625)
    end

    it "sends a POST without an Idempotency-Key once" do
      server.respond([503, {}, ""], data({}))
      expect { client.create_connection(webhook_url: "https://app.test/hook") }.to raise_error(QubeSync::APIError)
      expect { client.answer("/connections/c1/workflow-runs/r1/decisions", choice: "a") }.not_to raise_error
      expect(server.recorded.size).to eq(2)
      expect(sleeps).to be_empty
    end

    [400, 404, 409, 422].each do |status|
      it "never retries a #{status}" do
        server.respond(json(status, {"errors" => "no"}))
        expect { client.get_connection("c1") }.to raise_error(QubeSync::APIError)
        expect(server.recorded.size).to eq(1)
        expect(sleeps).to be_empty
      end
    end

    it "retries a refused connection, then raises Errno::ECONNREFUSED" do
      closed = TCPServer.new("127.0.0.1", 0)
      port = closed.addr[1]
      closed.close
      c = described_class.new(api_key: api_key, base_url: "http://127.0.0.1:#{port}", sleep: ->(s) { sleeps << s })
      expect { c.list_connections }.to raise_error(Errno::ECONNREFUSED)
      expect(sleeps.size).to eq(2)
    end

    it "retries a reset connection" do
      server.respond(:reset, data([{"id" => "c1"}]))
      expect(client.list_connections).to eq([{"id" => "c1"}])
      expect(server.recorded.size).to eq(2)
    end

    it "doesn't retry a reset connection for a POST without a key" do
      server.respond(:reset)
      expect { client.create_connection(webhook_url: "https://app.test/hook") }
        .to raise_error(StandardError) { |e| expect(e).not_to be_a(QubeSync::Error) }
      expect(server.recorded.size).to eq(1)
    end

    it "passes the read timeout, and raises Net::ReadTimeout after the retries" do
      slow = ->(_req) { sleep 1; data([]) }
      server.respond(slow, slow, slow)
      c = described_class.new(api_key: api_key, base_url: server.url, read_timeout: 0.2, sleep: ->(s) { sleeps << s })
      expect { c.list_connections }.to raise_error(Net::ReadTimeout)
      expect(sleeps.size).to eq(2)
    end

    it "max_retries: 0 sends once" do
      server.respond([503, {}, ""])
      c = described_class.new(api_key: api_key, base_url: server.url, max_retries: 0, sleep: ->(s) { sleeps << s })
      expect { c.list_connections }.to raise_error(QubeSync::APIError)
      expect(server.recorded.size).to eq(1)
    end
  end

  describe "on_retry" do
    let(:events) { [] }
    let(:client) do
      described_class.new(api_key: api_key, base_url: server.url, sleep: ->(s) { sleeps << s },
        on_retry: ->(info) { events << info })
    end

    it "is called before each retry's wait, for a status, with the query stripped" do
      server.respond([503, {}, ""], [503, {}, ""], data([]))
      client.list_runs("c1", reference: "secret-search")
      expect(events.size).to eq(2)
      first = events.first
      expect(first).to be_frozen
      expect(first.keys).to eq(%i[attempt max_retries delay elapsed method url status error])
      expect(first).to include(attempt: 1, max_retries: 2, method: "GET", status: 503, error: nil,
        url: "#{server.url}/api/v2/connections/c1/workflow-runs")
      expect(first[:delay]).to eq(sleeps.first)
      expect(first[:delay]).to be_a(Float)
      expect(first[:elapsed]).to be_a(Float)
      expect(events[1][:attempt]).to eq(2)
      expect(events.inspect).not_to include(api_key)
      expect(events.inspect).not_to include(["#{api_key}:"].pack("m0"))
      expect(events.inspect).not_to include("secret-search")
    end

    it "is called with the error for a refused connection" do
      closed = TCPServer.new("127.0.0.1", 0)
      port = closed.addr[1]
      closed.close
      c = described_class.new(api_key: api_key, base_url: "http://127.0.0.1:#{port}", sleep: ->(s) {},
        on_retry: ->(info) { events << info })
      expect { c.list_connections }.to raise_error(Errno::ECONNREFUSED)
      expect(events.map { |e| e[:attempt] }).to eq([1, 2])
      expect(events.first[:status]).to be_nil
      expect(events.first[:error]).to be_a(Errno::ECONNREFUSED)
    end

    it "is called with the error for a reset connection" do
      server.respond(:reset, data([]))
      client.list_connections
      expect(events.size).to eq(1)
      expect(events.first[:error]).to be_a(StandardError)
      expect(events.first[:status]).to be_nil
    end

    it "isn't called on success, a 4xx or once retries run out" do
      server.respond(data([]), json(404, {"errors" => {"detail" => "Not Found"}}))
      client.list_connections
      expect { client.get_connection("c1") }.to raise_error(QubeSync::APIError)
      expect(events).to be_empty

      c = described_class.new(api_key: api_key, base_url: server.url, max_retries: 1, sleep: ->(s) {},
        on_retry: ->(info) { events << info })
      server.respond([503, {}, ""], [503, {}, ""])
      expect { c.list_connections }.to raise_error(QubeSync::APIError)
      expect(events.size).to eq(1)
    end

    it "stops the call when it raises" do
      c = described_class.new(api_key: api_key, base_url: server.url, sleep: ->(s) { sleeps << s },
        on_retry: ->(_info) { raise "stop" })
      server.respond([503, {}, ""], data([]))
      expect { c.list_connections }.to raise_error(RuntimeError, "stop")
      expect(server.recorded.size).to eq(1)
      expect(sleeps).to be_empty
    end

    it "must be callable" do
      expect { described_class.new(api_key: api_key, on_retry: 1) }.to raise_error(ArgumentError)
    end
  end

  describe "total_timeout" do
    let(:now) { [0.0] }
    let(:events) { [] }

    # A clock that runs in real time and jumps forward by every injected sleep.
    def timed_client(**options)
      offset = 0.0
      described_class.new(api_key: api_key, base_url: server.url,
        sleep: ->(s) { sleeps << s; offset += s },
        clock: -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) + offset },
        on_retry: ->(info) { events << info }, **options)
    end

    it "defaults to 60 seconds" do
      expect(described_class.new(api_key: api_key).total_timeout).to eq(60)
      expect { described_class.new(api_key: api_key, total_timeout: 0) }.to raise_error(ArgumentError)
    end

    it "makes no retry whose wait leaves under a second" do
      server.respond([503, {}, ""], data([]))
      c = timed_client(total_timeout: 1.5)
      expect { c.list_connections }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(503) }
      expect(server.recorded.size).to eq(1)
      expect(sleeps).to be_empty
      expect(events).to be_empty
    end

    it "never waits a Retry-After beyond the limit, nor shortens it" do
      server.respond([429, {"Retry-After" => "20"}, ""], data([]))
      c = timed_client(total_timeout: 10)
      expect { c.list_connections }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(429) }
      expect(server.recorded.size).to eq(1)
      expect(sleeps).to be_empty
    end

    it "raises the network error when the retry doesn't fit" do
      server.respond(:reset)
      c = timed_client(total_timeout: 1.2)
      expect { c.list_connections }.to raise_error(StandardError) { |e| expect(e).not_to be_a(QubeSync::Error) }
      expect(server.recorded.size).to eq(1)
    end

    it "cuts a later attempt's read timeout to the time left" do
      slow = ->(_req) { sleep 5; data([]) }
      server.respond([503, {}, ""], slow)
      c = timed_client(total_timeout: 2.2, read_timeout: 30)
      started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      expect { c.list_connections }.to raise_error(Net::ReadTimeout)
      real = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started
      expect(server.recorded.size).to eq(2)
      expect(events.size).to eq(1)
      # 2.2 s less the first wait (0.5 to 0.625 s), and no third attempt.
      expect(real).to be_between(1.4, 2.0)
    end
  end

  describe "answer retries" do
    it "retries on 503 when the link has a prompt_token" do
      server.respond([503, {}, ""], data({"id" => "r1"}))
      client.answer("/connections/c1/workflow-runs/r1/decisions?prompt_token=tok", choice: "a")
      expect(server.recorded.size).to eq(2)
      expect(server.recorded.map(&:query)).to eq(["prompt_token=tok", "prompt_token=tok"])
      expect(sleeps.size).to eq(1)
    end

    it "is sent once without a prompt_token, or with an empty one" do
      server.respond([503, {}, ""], [503, {}, ""])
      expect { client.answer("/connections/c1/workflow-runs/r1/decisions", choice: "a") }.to raise_error(QubeSync::APIError)
      expect { client.answer("/connections/c1/workflow-runs/r1/decisions?prompt_token=", choice: "a") }.to raise_error(QubeSync::APIError)
      expect(server.recorded.size).to eq(2)
      expect(sleeps).to be_empty
    end

    it "leaves other POSTs to a link with a prompt_token unretried" do
      server.respond([503, {}, ""])
      expect { client.request(:post, "/connections/c1/workflow-runs/r1/decisions?prompt_token=tok", {choice: "a"}) }
        .to raise_error(QubeSync::APIError)
      expect(server.recorded.size).to eq(1)
    end
  end

  describe "a retried DELETE that finds nothing" do
    let(:not_found) { json(404, {"errors" => {"detail" => "Not Found"}}) }

    it "succeeds when the first attempt timed out after deleting" do
      deleted = []
      slow_delete = ->(req) { deleted << req.path; sleep 1; [204, {}, ""] }
      server.respond(slow_delete, not_found)
      c = described_class.new(api_key: api_key, base_url: server.url, read_timeout: 0.2, sleep: ->(s) { sleeps << s })
      expect(c.delete_connection("c1")).to be_nil
      expect(deleted).to eq(["/api/v2/connections/c1"])
      expect(server.recorded.size).to eq(2)
    end

    it "succeeds after a reset or a 504" do
      server.respond(:reset, not_found, [504, {}, ""], not_found)
      expect(client.delete_connection("c1")).to be_nil
      expect(client.request(:delete, "/workflows/w1")).to be_nil
      expect(server.recorded.size).to eq(4)
    end

    it "raises a first attempt's 404" do
      server.respond(not_found)
      expect { client.delete_connection("c1") }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(404) }
    end

    it "raises a 404 after a 503 or a 429" do
      server.respond([503, {}, ""], not_found, [429, {}, ""], not_found)
      expect { client.delete_connection("c1") }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(404) }
      expect { client.delete_connection("c1") }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(404) }
    end

    it "raises a 404 after a refused connection" do
      closed = TCPServer.new("127.0.0.1", 0)
      port = closed.addr[1]
      closed.close
      late = nil
      # Nothing listens on the first attempt; the server starts during the wait before the retry.
      starter = lambda do |s|
        sleeps << s
        late ||= FakeQubeServer.new(port).respond(not_found)
      end
      c = described_class.new(api_key: api_key, base_url: "http://127.0.0.1:#{port}", sleep: starter)
      expect { c.delete_connection("c1") }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(404) }
      expect(late.recorded.size).to eq(1)
    ensure
      late&.stop
    end

    it "raises a 404 for a GET after a lost answer" do
      server.respond([504, {}, ""], not_found)
      expect { client.get_connection("c1") }.to raise_error(QubeSync::APIError) { |e| expect(e.status).to eq(404) }
    end
  end

  describe "APIError" do
    def error_for(response)
      server.respond(response)
      client.get_connection("c1")
    rescue QubeSync::APIError => e
      e
    end

    it "is a QubeSync::Error" do
      expect(QubeSync::APIError.ancestors).to include(QubeSync::Error, StandardError)
    end

    it "reads a sentence" do
      e = error_for(json(422, {"errors" => "unknown parameter: \"emial\""}, "x-request-id" => "req-1"))
      expect(e.status).to eq(422)
      expect(e.errors).to eq("unknown parameter: \"emial\"")
      expect(e.code).to be_nil
      expect(e.message).to eq("QuBe Sync answered 422: unknown parameter: \"emial\"")
      expect(e.request_id).to eq("req-1")
      expect(e.body).to eq(JSON.generate({"errors" => "unknown parameter: \"emial\""}))
    end

    it "reads detail and code" do
      e = error_for(json(409, {"errors" => {"detail" => "The question changed", "code" => "prompt_changed"}}))
      expect(e.code).to eq("prompt_changed")
      expect(e.errors).to eq({"detail" => "The question changed", "code" => "prompt_changed"})
      expect(e.message).to eq("QuBe Sync answered 409: The question changed")
      expect(e.request_id).to be_nil
    end

    it "reads fields" do
      e = error_for(json(422, {"errors" => {"webhook_url" => ["can't be blank", "is invalid"], "name" => ["is too long"]}}))
      expect(e.code).to be_nil
      expect(e.message).to eq("QuBe Sync answered 422: webhook_url: can't be blank, is invalid; name: is too long")
    end

    it "reads a list of problems" do
      e = error_for(json(422, {"errors" => [{"path" => "input.customer", "message" => "is required"}, {"path" => "input.total", "message" => "must be a number"}]}))
      expect(e.errors.size).to eq(2)
      expect(e.message).to eq("QuBe Sync answered 422: input.customer: is required; input.total: must be a number")
    end

    it "reads the plain-text 401" do
      e = error_for([401, {"WWW-Authenticate" => "Basic realm=\"Application\""}, "Unauthorized\n"])
      expect(e.status).to eq(401)
      expect(e.errors).to be_nil
      expect(e.code).to be_nil
      expect(e.body).to eq("Unauthorized\n")
      expect(e.message).to eq("QuBe Sync answered 401: Unauthorized")
    end

    it "trims a long raw body to 500 characters, on one line" do
      e = error_for([500, {}, "line one\nline two " + ("x" * 1000)])
      expect(e.message).to start_with("QuBe Sync answered 500: line one line two x")
      expect(e.message.length).to be <= "QuBe Sync answered 500: ".length + 500
      expect(e.message).not_to include("\n")
    end

    it "never holds the key" do
      e = error_for(json(404, {"errors" => {"detail" => "Not Found"}}))
      [e.message, e.inspect, e.full_message].each do |text|
        expect(text).not_to include(api_key)
        expect(text).not_to include(["#{api_key}:"].pack("m0"))
      end
    end
  end
end
