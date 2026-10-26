# frozen_string_literal: true

require "json"
require "net/http"
require "securerandom"
require "time"
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
    # A retry is made only when at least this many seconds are left before total_timeout.
    MIN_TIME_LEFT = 1
    RETRY_SAFE_METHODS = %w[GET PUT DELETE].freeze
    METHODS = %w[GET POST PUT DELETE PATCH].freeze
    QUEUE_METHODS = %w[GET POST PUT DELETE].freeze
    NETWORK_ERRORS = [
      Net::OpenTimeout, Net::ReadTimeout, Net::WriteTimeout,
      Errno::ECONNREFUSED, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE,
      Errno::EHOSTUNREACH, Errno::ENETUNREACH, Errno::ETIMEDOUT,
      EOFError, IOError, SocketError
    ].freeze
    # Failures after the request may have reached QuBe Sync: its answer was lost, so the request
    # may have been carried out.
    ANSWER_LOST_ERRORS = [
      Net::ReadTimeout, Net::WriteTimeout, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE, EOFError, IOError
    ].freeze
    ANSWER_LOST_STATUSES = [502, 504].freeze

    attr_reader :base_url, :open_timeout, :read_timeout, :max_retries, :total_timeout

    # `api_key` is required. `base_url` is the site, without `/api/v2`. `open_timeout` and
    # `read_timeout` are seconds, per attempt. `max_retries` is how many times a retry-safe
    # request is sent again. `total_timeout` (seconds) bounds a whole call, retries and their
    # waits included. `on_retry` is a callable, called before each retry's wait with a frozen
    # Hash: `attempt`, `max_retries`, `delay`, `elapsed`, `method`, `url` (without its query),
    # `status` and `error`; an exception it raises stops the call and reaches the caller.
    # `sleep` (a callable taking seconds) and `clock` (a callable returning monotonic seconds)
    # are for tests.
    def initialize(api_key:, base_url: DEFAULT_BASE_URL, open_timeout: 5, read_timeout: 30, max_retries: 2,
      total_timeout: 60, on_retry: nil, sleep: nil, clock: nil)
      unless api_key.is_a?(String) && !api_key.strip.empty?
        raise ArgumentError, "api_key is required"
      end
      unless max_retries.is_a?(Integer) && max_retries >= 0
        raise ArgumentError, "max_retries must be a non-negative Integer"
      end
      unless total_timeout.is_a?(Numeric) && total_timeout.positive?
        raise ArgumentError, "total_timeout must be a positive number of seconds"
      end
      unless on_retry.nil? || on_retry.respond_to?(:call)
        raise ArgumentError, "on_retry must respond to call"
      end

      @base_url = base_url.to_s.sub(%r{/+\z}, "")
      @base_uri = parse_http_uri(@base_url)
      raise ArgumentError, "base_url must be an absolute http or https URL" unless @base_uri

      @authorization = "Basic #{["#{api_key}:"].pack("m0")}"
      @open_timeout = open_timeout
      @read_timeout = read_timeout
      @max_retries = max_retries
      @total_timeout = total_timeout
      @on_retry = on_retry
      @sleep = sleep || ->(seconds) { Kernel.sleep(seconds) }
      @clock = clock || -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) }
    end

    def inspect
      "#<#{self.class.name} base_url=#{@base_url}>"
    end
    alias to_s inspect

    # -- Connections ------------------------------------------------------------------------

    # type: "simulated" makes a connection to a simulated QuickBooks company file, connected as
    # it's made (connection.connected comes at once), for testing with no Windows computer.
    def create_connection(webhook_url:, name: nil, type: nil)
      call(:post, "/connections", compact(webhook_url: webhook_url, name: name, type: type))
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

    # Asks QuBe Sync to send the run's latest event again (its ending, or the question it's
    # waiting on) to the run's webhook URL, signed, with the revision it carries, so a receiver
    # that missed it, or was down for longer than the retries, catches up. Returns
    # `{"run_id", "event", "revision", "webhook_url"}`. A run with nothing to send yet answers
    # 409 (APIError), and one asked again too soon 429.
    def redeliver_run(connection_id, run_id)
      call(:post, "/connections/#{segment(connection_id)}/workflow-runs/#{segment(run_id)}/redeliver")
    end

    # Returns the whole body: `{"data" => [...], "next_after" => ...}`.
    def run_events(connection_id, run_id, after: nil, limit: nil)
      request(:get, "/connections/#{segment(connection_id)}/workflow-runs/#{segment(run_id)}/events",
        query: {after: after, limit: limit})
    end

    # -- Workflow types ---------------------------------------------------------------------

    # The input types of the app's workflows, which `qube_sync workflows` renders into a typed
    # file (QubeSync::WorkflowTypes). Returns the document (the response's data): `digest`,
    # `operations_digest`, `include_drafts`, `workflows` (each published workflow at its
    # published version) and, with `include_drafts: true`, `drafts` (each workflow whose working
    # copy differs from it). With `etag:` (a document's `digest`, or the ETag it came with),
    # returns :not_modified when the document is still that one.
    def workflow_types(include_drafts: false, etag: nil)
      headers = {}
      headers["If-None-Match"] = entity_tag(etag) unless etag.nil? || etag.to_s.empty?
      call(:get, "/workflows/types", query: {include: include_drafts ? "drafts" : nil}, headers: headers)
    rescue APIError => e
      raise unless e.status == 304

      :not_modified
    end

    # -- Questions --------------------------------------------------------------------------

    # `decisions_url` is the run's `links.decisions`. It's retried like a GET when the link
    # carries a `prompt_token` (a run's link always does while it asks), since the token ties the
    # answer to one question. A retry after a lost answer may raise APIError 409 with code
    # `prompt_changed`: the question has been answered, by the first attempt or by someone else.
    # Without a `prompt_token` it's sent once.
    def answer(decisions_url, choice:, data: nil)
      call(:post, decisions_url, compact(choice: choice, data: data), retry_safe: prompt_token?(decisions_url))
    end

    # `search_url` is the run's `links.search`. Returns the matches, an Array.
    def search(search_url, field:, q:)
      call(:get, search_url, query: {field: field, q: q})
    end

    # -- Queued requests --------------------------------------------------------------------

    # Queues a QuickBooks operation by its id, as `client.customer.create(...)` and the other
    # entity methods do: `queue("customer.create", connection_id, {name: "Acme"}, webhook_url:)`.
    # The params go as the JSON body or the query string, as the operation takes them, and
    # `webhook_url` in the query string. Without `idempotency_key:`, the client makes a UUID for
    # this call and sends the same one on its retries.
    #
    # For an operation newer than this version of the gem, pass `method:` (`:post`, `:get`,
    # `:put`, `:delete`) and `path:`, relative to the connection (`"customers"`); a GET sends the
    # params as the query string, any other method as the body. For a known id they replace the
    # index's.
    def queue(operation_id, connection_id, params = {}, webhook_url:, idempotency_key: nil, method: nil, path: nil)
      entry = Operations::INDEX[operation_id.to_s]
      if entry.nil? && (method.nil? || path.nil?)
        raise ArgumentError, "unknown operation #{operation_id.to_s.inspect}: pass method: and path: for an operation " \
          "this version of qube_sync doesn't know"
      end

      verb = (method || entry[:method]).to_s.upcase
      raise ArgumentError, "method must be one of :get, :post, :put, :delete" unless QUEUE_METHODS.include?(verb)

      params_in = (method.nil? && entry) ? entry[:params_in] : (verb == "GET" ? :query : :body)
      full_path = "/connections/#{segment(connection_id)}/#{operation_path(path || entry[:path])}"
      params ||= {}
      query = {webhook_url: webhook_url}
      body = nil
      if params_in == :query
        query = query.merge(params.to_h.reject { |name, _| name.to_s == "webhook_url" })
      else
        body = params
      end

      call(verb, full_path, body, query: query, headers: {"Idempotency-Key" => key_for(idempotency_key)})
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
      perform(method, path_or_url, body, query: query, headers: headers)
    end

    private

    def perform(method, path_or_url, body, query:, headers:, retry_safe: false)
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

      retry_safe ||= RETRY_SAFE_METHODS.include?(verb) ||
        request_headers.any? { |name, value| name.casecmp?("idempotency-key") && !value.empty? }

      send_with_retries(verb, uri, request_headers, payload, retry_safe)
    end

    def call(method, path_or_url, body = nil, query: {}, headers: {}, retry_safe: false)
      parsed = perform(method, path_or_url, body, query: query, headers: headers, retry_safe: retry_safe)
      parsed.is_a?(Hash) ? parsed["data"] : parsed
    end

    def send_with_retries(verb, uri, headers, payload, retry_safe)
      started = @clock.call
      attempt = 0
      answer_lost = false
      loop do
        error = nil
        response = nil
        time_left = @total_timeout - (@clock.call - started)
        begin
          response = send_once(verb, uri, headers, payload, time_left)
        rescue *NETWORK_ERRORS => e
          error = e
        end

        status = response&.code.to_i
        # A retried DELETE that finds nothing, after an earlier attempt's answer was lost, did
        # what it was asked: that attempt deleted it.
        return nil if verb == "DELETE" && status == 404 && answer_lost

        answer_lost ||= ANSWER_LOST_ERRORS.any? { |klass| error.is_a?(klass) } ||
          ANSWER_LOST_STATUSES.include?(status)
        retryable = error || RETRY_STATUSES.include?(status)
        if retryable && retry_safe && attempt < @max_retries
          delay = error ? backoff(attempt) : retry_delay(attempt, status, response)
          elapsed = @clock.call - started
          if @total_timeout - elapsed - delay >= MIN_TIME_LEFT
            notify_retry(attempt + 1, delay, elapsed, verb, uri, error ? nil : status, error)
            @sleep.call(delay)
            attempt += 1
            next
          end
        end

        raise error if error
        return parse_body(response) if (200..299).cover?(status)

        raise APIError.new(status: status, body: response.body, request_id: response["x-request-id"])
      end
    end

    def notify_retry(attempt, delay, elapsed, verb, uri, status, error)
      return unless @on_retry

      url = uri.dup
      url.query = nil
      url.fragment = nil
      @on_retry.call({
        attempt: attempt, max_retries: @max_retries, delay: delay.to_f, elapsed: elapsed.to_f,
        method: verb, url: url.to_s, status: status, error: error
      }.freeze)
    end

    # Each attempt's timeouts are the configured ones, cut to the time left before total_timeout.
    def send_once(verb, uri, headers, payload, time_left)
      time_left = [time_left, 0.001].max
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = [@open_timeout, time_left].min
      http.read_timeout = [@read_timeout, time_left].min
      http.write_timeout = [@read_timeout, time_left].min
      http.max_retries = 0 # the client retries, and only what's safe to send again

      request = Net::HTTPGenericRequest.new(verb, !payload.nil?, verb != "HEAD", uri.request_uri, headers)
      request.body = payload unless payload.nil?
      http.start { |connection| connection.request(request) }
    end

    def prompt_token?(link)
      query = URI.parse(link.to_s).query
      return false if query.nil?

      URI.decode_www_form(query).any? { |name, value| name == "prompt_token" && !value.to_s.empty? }
    rescue URI::InvalidURIError, ArgumentError
      false
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

    # Query strings as the v2 API reads them: an array of scalars repeats its bare key
    # (`list_id=1&list_id=2`); a nested Hash brackets its keys (`name_range[from]=A`), and an
    # array inside one brackets too (`currency_filter[list_id][]=1`). nil values are left out,
    # booleans are `true`/`false`, a Time or Date is ISO 8601.
    def encode_query(query)
      raise ArgumentError, "query must be a Hash" unless query.nil? || query.is_a?(Hash)

      pairs = []
      (query || {}).each { |name, value| query_pairs(name.to_s, value, true, pairs) }
      URI.encode_www_form(pairs)
    end

    def query_pairs(key, value, top, pairs)
      case value
      when nil
        nil
      when Array
        value.each do |item|
          next if item.nil?
          raise ArgumentError, "query parameter #{key} can't hold an array of arrays" if item.is_a?(Array)

          if item.is_a?(Hash)
            query_pairs("#{key}[]", item, false, pairs)
          else
            pairs << [top ? key : "#{key}[]", query_scalar(key, item)]
          end
        end
      when Hash
        value.each { |name, inner| query_pairs("#{key}[#{name}]", inner, false, pairs) }
      else
        pairs << [key, query_scalar(key, value)]
      end
    end

    def query_scalar(key, value)
      case value
      when String, Symbol, Numeric, true, false then value.to_s
      when Time then value.iso8601
      else
        return value.iso8601 if value.respond_to?(:iso8601)

        raise ArgumentError, "query parameter #{key} must be a String, Numeric, boolean, Array or Hash"
      end
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

    def entity_tag(value)
      text = value.to_s
      (text.start_with?("\"") || text.start_with?("W/")) ? text : "\"#{text}\""
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

require_relative "operations"
