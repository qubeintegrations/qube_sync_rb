# frozen_string_literal: true

require "json"
require "net/http"
require "securerandom"
require "uri"
require_relative "version"

module QubeSync
  class Error < StandardError; end

  # Any answer from QuBe Sync outside 2xx, after the retries.
  #
  # - `status`: the HTTP status, an Integer.
  # - `errors`: the body's `errors` as parsed (a String, a Hash or an Array), or nil when the
  #   body isn't JSON or has none.
  # - `code`: `errors["code"]` when `errors` is a Hash with a String `code` (`"prompt_changed"`,
  #   `"not_awaiting_input"`...), else nil.
  # - `message`: one line, `"QuBe Sync answered <status>: <text>"`.
  # - `body`: the raw response body.
  # - `request_id`: the `x-request-id` response header, for support, or nil.
  #
  # It never holds the API key or the Authorization header.
  class APIError < Error
    MAX_RAW = 500

    attr_reader :status, :errors, :code, :body, :request_id

    def initialize(status:, body: "", request_id: nil)
      @status = Integer(status)
      @body = body.to_s
      @request_id = request_id
      parsed = parse_json(@body)
      @errors = parsed.is_a?(Hash) ? parsed["errors"] : nil
      @code = @errors.is_a?(Hash) && @errors["code"].is_a?(String) ? @errors["code"] : nil
      super("QuBe Sync answered #{@status}: #{summary}")
    end

    private

    def parse_json(text)
      JSON.parse(text)
    rescue JSON::ParserError
      nil
    end

    def summary
      text =
        case @errors
        when String
          @errors
        when Hash
          if @errors["detail"].is_a?(String)
            @errors["detail"]
          else
            @errors.map { |field, messages| "#{field}: #{Array(messages).join(", ")}" }.join("; ")
          end
        when Array
          @errors.map do |problem|
            if problem.is_a?(Hash)
              "#{problem["path"]}: #{problem["message"]}"
            else
              problem.to_s
            end
          end.join("; ")
        end

      text = raw_summary if text.nil? || text.strip.empty?
      text.gsub(/\s+/, " ").strip
    end

    def raw_summary
      raw = @body.strip
      raw.empty? ? "(no body)" : raw[0, MAX_RAW]
    end
  end

  # A client for the QuBe Sync v2 API.
  #
  #   client = QubeSync::Client.new(api_key: ENV.fetch("QUBE_API_KEY"))
  #   connection = client.create_connection(webhook_url: "https://myapp.example/qube/connection")
  #   connection["links"]["onboarding"] # send the customer here
  #
  # Every method returns the response's `data` (a Hash or an Array with String keys) unless its
  # documentation says otherwise, and nil for an empty answer. Anything outside 2xx raises
  # QubeSync::APIError. A connection that still fails after the retries raises Ruby's own error
  # (Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED...).
  #
  # It uses only the standard library: `require "qube_sync/client"` loads neither Faraday nor
  # the v1 functions. It never reads the environment.
  class Client
    DEFAULT_BASE_URL = "https://qubesync.com"
    API_PATH = "/api/v2"
    RETRY_STATUSES = [429, 502, 503, 504].freeze
    RETRY_AFTER_STATUSES = [429, 503].freeze
    MAX_RETRY_AFTER = 30
    RETRY_SAFE_METHODS = %w[GET PUT DELETE].freeze
    METHODS = %w[GET POST PUT DELETE PATCH].freeze
    QUEUE_METHODS = %w[GET POST PUT DELETE].freeze
    NETWORK_ERRORS = [
      Net::OpenTimeout, Net::ReadTimeout, Net::WriteTimeout,
      Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE,
      Errno::EHOSTUNREACH, Errno::ENETUNREACH, Errno::ETIMEDOUT,
      EOFError, IOError, SocketError
    ].freeze

    attr_reader :base_url, :open_timeout, :read_timeout, :max_retries

    # `api_key` is required. `base_url` is the site, without `/api/v2`. `open_timeout` and
    # `read_timeout` are seconds. `max_retries` is how many times a retry-safe request is sent
    # again. `sleep` is a callable taking seconds, for tests.
    def initialize(api_key:, base_url: DEFAULT_BASE_URL, open_timeout: 5, read_timeout: 30, max_retries: 2, sleep: nil)
      unless api_key.is_a?(String) && !api_key.strip.empty?
        raise ArgumentError, "api_key is required"
      end
      unless max_retries.is_a?(Integer) && max_retries >= 0
        raise ArgumentError, "max_retries must be a non-negative Integer"
      end

      @base_url = base_url.to_s.sub(%r{/+\z}, "")
      @base_uri = parse_http_uri(@base_url)
      raise ArgumentError, "base_url must be an absolute http or https URL" unless @base_uri

      @authorization = "Basic #{["#{api_key}:"].pack("m0")}"
      @open_timeout = open_timeout
      @read_timeout = read_timeout
      @max_retries = max_retries
      @sleep = sleep || ->(seconds) { Kernel.sleep(seconds) }
    end

    def inspect
      "#<#{self.class.name} base_url=#{@base_url}>"
    end
    alias to_s inspect

    # -- Connections ------------------------------------------------------------------------

    def create_connection(webhook_url:, name: nil)
      call(:post, "/connections", compact(webhook_url: webhook_url, name: name))
    end

    def get_connection(id)
      call(:get, "/connections/#{segment(id)}")
    end

    def list_connections
      call(:get, "/connections")
    end

    def update_connection(id, webhook_url: nil, name: nil)
      call(:put, "/connections/#{segment(id)}", compact(webhook_url: webhook_url, name: name))
    end

    def delete_connection(id)
      call(:delete, "/connections/#{segment(id)}")
    end

    def regenerate_onboarding(id)
      call(:post, "/connections/#{segment(id)}/onboarding-url")
    end

    # Returns `{"id" => ..., "password" => ...}`.
    def set_password(id, password: nil)
      body = password.nil? ? nil : {password: password}
      call(:post, "/connections/#{segment(id)}/password", body)
    end

    # Returns the QWC file's XML as a String.
    def get_qwc(id)
      body = request(:post, "/connections/#{segment(id)}/qwc")
      body.is_a?(Hash) ? body["qwc"] : nil
    end

    # -- Workflow runs ----------------------------------------------------------------------

    # Sends `reference` as the Idempotency-Key, so a retry never starts a second run.
    def start_run(connection_id, workflow, input, reference:, webhook_url:, version: nil)
      body = compact(workflow: workflow, reference: reference, input: input, webhook_url: webhook_url, version: version)
      call(:post, "/connections/#{segment(connection_id)}/workflow-runs", body,
        headers: {"Idempotency-Key" => reference.to_s})
    end

    # `get_run(run["links"]["run"])` or `get_run(connection_id, run_id)`.
    def get_run(run_url_or_connection_id, run_id = nil)
      if run_id.nil?
        call(:get, run_url_or_connection_id)
      else
        call(:get, "/connections/#{segment(run_url_or_connection_id)}/workflow-runs/#{segment(run_id)}")
      end
    end

    def list_runs(connection_id, reference: nil, state: nil, outcome: nil)
      call(:get, "/connections/#{segment(connection_id)}/workflow-runs",
        query: {reference: reference, state: state, outcome: outcome})
    end

    # `cancel_url` is the run's `links.cancel`.
    def cancel_run(cancel_url, reason: nil)
      call(:post, cancel_url, compact(reason: reason))
    end

    # Returns the whole body: `{"data" => [...], "next_after" => ...}`.
    def run_events(connection_id, run_id, after: nil, limit: nil)
      request(:get, "/connections/#{segment(connection_id)}/workflow-runs/#{segment(run_id)}/events",
        query: {after: after, limit: limit})
    end

    # -- Questions --------------------------------------------------------------------------

    # `decisions_url` is the run's `links.decisions`.
    def answer(decisions_url, choice:, data: nil)
      call(:post, decisions_url, compact(choice: choice, data: data))
    end

    # `search_url` is the run's `links.search`. Returns the matches, an Array.
    def search(search_url, field:, q:)
      call(:get, search_url, query: {field: field, q: q})
    end

    # -- Queued requests --------------------------------------------------------------------

    # Queues a QuickBooks operation: `operation` is the path after the connection
    # (`"customers"`, `"invoices"`, `"txn-deleteds"`...). For `:get` and `:delete` the params go
    # in the query string (scalars or arrays), for `:post` and `:put` as the JSON body.
    # `webhook_url` goes in the query string. Without `idempotency_key:`, the client makes a
    # UUID for this call and sends the same one on its retries.
    def queue(connection_id, operation, params = {}, webhook_url:, method: :post, idempotency_key: nil)
      verb = method.to_s.upcase
      raise ArgumentError, "method must be one of :get, :post, :put, :delete" unless QUEUE_METHODS.include?(verb)

      path = "/connections/#{segment(connection_id)}/#{operation_path(operation)}"
      params ||= {}
      query = {webhook_url: webhook_url}
      body = nil
      if %w[GET DELETE].include?(verb)
        query = params.to_h.merge(query)
      else
        body = params
      end

      call(verb, path, body, query: query, headers: {"Idempotency-Key" => key_for(idempotency_key)})
    end

    # Queues qbXML as written.
    def queue_qbxml(connection_id, request_xml, webhook_url:, idempotency_key: nil)
      call(:post, "/connections/#{segment(connection_id)}/queued-requests", {request_xml: request_xml},
        query: {webhook_url: webhook_url}, headers: {"Idempotency-Key" => key_for(idempotency_key)})
    end

    def get_request(connection_id, id)
      call(:get, "/connections/#{segment(connection_id)}/queued-requests/#{segment(id)}")
    end

    def request_pages(connection_id, id)
      call(:get, "/connections/#{segment(connection_id)}/queued-requests/#{segment(id)}/pages")
    end

    # Returns the whole body: `{"data" => [...], "meta" => {"page" => 1, "total_pages" => 3}}`.
    def list_requests(connection_id, page: nil, page_size: nil, state: nil, webhook_state: nil, sort: nil,
      sort_direction: nil, search_phrase: nil)
      query = {
        page: page, page_size: page_size, state: state, webhook_state: webhook_state, sort: sort,
        sort_direction: sort_direction, search_phrase: search_phrase
      }
      request(:get, "/connections/#{segment(connection_id)}/queued-requests", query: query)
    end

    # Yields every request on every page, fetching page after page. Takes `list_requests`'
    # filters. Without a block, returns an Enumerator.
    def each_request(connection_id, **filters, &block)
      return enum_for(:each_request, connection_id, **filters) unless block

      page = filters.delete(:page) || 1
      loop do
        body = list_requests(connection_id, **filters, page: page)
        data = body.is_a?(Hash) ? Array(body["data"]) : []
        break if data.empty?

        data.each(&block)
        total_pages = body.dig("meta", "total_pages")
        break if !total_pages.is_a?(Integer) || page >= total_pages

        page += 1
      end
      nil
    end

    def discard_request(connection_id, id)
      call(:post, "/connections/#{segment(connection_id)}/queued-requests/#{segment(id)}/discard")
    end

    # -- Anything else ----------------------------------------------------------------------

    # Sends any request and returns the parsed JSON body whole (not just `data`), or nil for an
    # empty answer. `path_or_url` is a path under /api/v2 (starting with "/") or an absolute URL
    # on this client's own origin. `body` is sent as JSON (a String as is).
    def request(method, path_or_url, body = nil, query: {}, headers: {})
      verb = method.to_s.upcase
      raise ArgumentError, "unsupported method #{method.inspect}" unless METHODS.include?(verb)

      uri = build_uri(path_or_url, query)
      request_headers = {
        "Accept" => "application/json",
        "User-Agent" => "qube_sync-ruby/#{QubeSync::VERSION}"
      }
      payload = nil
      unless body.nil?
        request_headers["Content-Type"] = "application/json"
        payload = body.is_a?(String) ? body : JSON.generate(body)
      end
      headers.each do |name, value|
        next if name.to_s.casecmp?("authorization")

        request_headers[name.to_s] = value.to_s
      end
      request_headers["Authorization"] = @authorization

      retry_safe = RETRY_SAFE_METHODS.include?(verb) ||
        request_headers.any? { |name, value| name.casecmp?("idempotency-key") && !value.empty? }

      send_with_retries(verb, uri, request_headers, payload, retry_safe)
    end

    private

    def call(method, path_or_url, body = nil, query: {}, headers: {})
      parsed = request(method, path_or_url, body, query: query, headers: headers)
      parsed.is_a?(Hash) ? parsed["data"] : parsed
    end

    def send_with_retries(verb, uri, headers, payload, retry_safe)
      attempt = 0
      loop do
        begin
          response = send_once(verb, uri, headers, payload)
        rescue *NETWORK_ERRORS
          raise unless retry_safe && attempt < @max_retries

          @sleep.call(backoff(attempt))
          attempt += 1
          next
        end

        status = response.code.to_i
        if RETRY_STATUSES.include?(status) && retry_safe && attempt < @max_retries
          @sleep.call(retry_delay(attempt, status, response))
          attempt += 1
          next
        end

        return parse_body(response) if (200..299).cover?(status)

        raise APIError.new(status: status, body: response.body, request_id: response["x-request-id"])
      end
    end

    def send_once(verb, uri, headers, payload)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = @open_timeout
      http.read_timeout = @read_timeout
      http.write_timeout = @read_timeout
      http.max_retries = 0 # the client retries, and only what's safe to send again

      request = Net::HTTPGenericRequest.new(verb, !payload.nil?, verb != "HEAD", uri.request_uri, headers)
      request.body = payload unless payload.nil?
      http.start { |connection| connection.request(request) }
    end

    def parse_body(response)
      text = response.body
      return nil if response.code.to_i == 204 || text.nil? || text.strip.empty?

      JSON.parse(text)
    end

    def backoff(attempt)
      [0.5 * (2**attempt), MAX_RETRY_AFTER].min * (1 + rand * 0.25)
    end

    def retry_delay(attempt, status, response)
      if RETRY_AFTER_STATUSES.include?(status)
        seconds = Float(response["retry-after"].to_s.strip, exception: false)
        return [seconds, MAX_RETRY_AFTER].min if seconds && seconds >= 0
      end
      backoff(attempt)
    end

    def build_uri(path_or_url, query)
      text = path_or_url.to_s
      uri =
        if text.start_with?("/")
          parse_http_uri("#{@base_url}#{API_PATH}#{text}") ||
            raise(ArgumentError, "not a valid path: #{text.inspect}")
        else
          link = parse_http_uri(text)
          raise ArgumentError, "expected a path starting with \"/\" or an absolute URL, got #{text.inspect}" unless link
          unless origin(link) == origin(@base_uri)
            raise ArgumentError, "refusing a link on #{origin(link)}: this client only sends requests to #{origin(@base_uri)}"
          end

          link
        end

      extra = encode_query(query)
      unless extra.empty?
        uri = uri.dup
        uri.query = [uri.query, extra].compact.reject(&:empty?).join("&")
      end
      uri
    end

    def parse_http_uri(text)
      uri = URI.parse(text)
      return nil unless uri.is_a?(URI::HTTP) && uri.host && !uri.host.empty?

      uri
    rescue URI::InvalidURIError
      nil
    end

    def origin(uri)
      "#{uri.scheme.downcase}://#{uri.host.downcase}:#{uri.port}"
    end

    def encode_query(query)
      pairs = []
      (query || {}).each do |name, value|
        next if value.nil?
        raise ArgumentError, "query parameter #{name} can't be a Hash" if value.is_a?(Hash)

        if value.is_a?(Array)
          value.each do |item|
            raise ArgumentError, "query parameter #{name} can't hold a Hash" if item.is_a?(Hash)

            pairs << [name.to_s, item.to_s] unless item.nil?
          end
        else
          pairs << [name.to_s, value.to_s]
        end
      end
      URI.encode_www_form(pairs)
    end

    def segment(value)
      text = value.to_s
      raise ArgumentError, "expected an id, got #{value.inspect}" if text.empty? || text == "." || text == ".."

      URI.encode_uri_component(text)
    end

    def operation_path(operation)
      parts = operation.to_s.sub(%r{\A/+}, "").split("/")
      raise ArgumentError, "expected an operation such as \"customers\"" if parts.empty?

      parts.map { |part| segment(part) }.join("/")
    end

    def key_for(idempotency_key)
      key = idempotency_key.nil? ? SecureRandom.uuid : idempotency_key.to_s
      raise ArgumentError, "idempotency_key can't be empty" if key.empty?

      key
    end

    def compact(hash)
      hash.compact
    end
  end
end
