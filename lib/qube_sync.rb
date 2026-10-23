require_relative "qube_sync/version"
require_relative "qube_sync/request_builder"
require "faraday"
require "json"
require "openssl"

module QubeSync
  class Error < StandardError; end
  class StaleWebhookError < Error; end
  class InvalidWebhookSignatureError < Error; end
  class ConfigError < Error; end
  
  module_function
    
    def base_url
      ENV.fetch("QUBE_URL", 'https://qubesync.com/api/v1')
    end
  
    def get(url, headers = {})
      response = connection.get(url) do |request|
        request.headers = default_headers.merge(headers)
      end
  
      case response.status
      when 200..299
        JSON.parse(response.body)
      else
        raise Error.new(<<~ERR
        Unexpected QUBE response: #{response.status}\n#{response.body}
  
        Request: #{url}
        Headers: #{headers}
        ERR
        ) 
      end
    end
  
    def connection
      Faraday.new(url: base_url) do |conn| 
        conn.request :authorization, :basic, api_key, ''
        conn.request :json
      end
    end
  
    def post(url, body = nil, headers = {})
      response = connection.post(url) do |request|
        request.headers = default_headers.merge(headers)
        request.body = body.to_json if body
      end
  
      case response.status
      when 200..299
        JSON.parse(response.body)
      else
        raise Error.new <<~ERR
        Unexpected QUBE response: #{response.status}\n#{response.body}
        ERR
      end
    end
  
    def delete(url, headers = {})
      response = connection.delete(url) do |request|
        request.headers = default_headers.merge(headers)
      end
  
      case response.status
      when 200..299
        true
      else
        raise <<~ERR
        Unexpected QUBE response: #{response.status}\n#{response.body}
        ERR
      end
    end
  
    def create_connection
      response = post("connections")
      connection_id = response.dig("data", "id") or raise "Connection ID not found: #{response.pretty_inspect}"
      yield connection_id if block_given?
      connection_id
    end
  
    def delete_connection(id)
      delete("connections/#{id}")
    end
  
    def get_connection(connection_id)
      get("connections/#{connection_id}").fetch("data")
    end

    def valid_connection?(connection_id)
      get_connection(connection_id)
      true
    rescue Error => e
      false
    end
  
    def queue_request(connection_id, request)
      url = "connections/#{connection_id}/queued_requests"

      raise "must have either request_xml or request_json" unless request[:request_xml] || request[:request_json]
      warn "no webhook_url provided" unless request[:webhook_url]
      payload = {
        queued_request: request
      }
  
      post(url, payload).fetch("data")
    end

    def get_request(id)
      get("queued_requests/#{id}").fetch("data")
    end

    def get_requests(connection_id)
      get("connections/#{connection_id}/queued_requests").fetch("data")
    end
  
    def delete_request(id)
      delete("queued_requests/#{id}")
    end
  
    def get_qwc(connection_id)
      post("connections/#{connection_id}/qwc")
        .fetch('qwc')
    end
  
    def generate_password(connection_id)
      response = post("connections/#{connection_id}/password")
      response.dig("data", "password") or raise "Password not found: #{response.pretty_inspect}"
    end
  
  
    # Parses an `X-QUBE-Signature` header, `t=<unix seconds>,v1=<hex>[,v1=<hex>]`,
    # by key. There is one `v1` per active webhook secret while a secret rotates.
    def extract_signature_meta(header)
      timestamp = nil
      signatures = []

      header.to_s.split(",").each do |part|
        key, value = part.strip.split("=", 2)
        case key
        when "t" then timestamp = value
        when "v1" then signatures << value if value && !value.empty?
        end
      end

      unless timestamp && timestamp.match?(/\A\d+\z/)
        raise InvalidWebhookSignatureError.new("Invalid X-QUBE-Signature header: no t=<unix seconds>")
      end

      {
        timestamp: timestamp.to_i,
        signatures: signatures
      }
    end

  
    def default_headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
      }
    end
  
    def api_key
      ENV.fetch('QUBE_API_KEY')
    rescue KeyError => e
      raise ConfigError.new("QUBE_API_KEY not set in environment. Your API key can be found/copied from your application page on https://qubesync.com/.")
    end
  
    def api_secret
      ENV.fetch('QUBE_WEBHOOK_SECRET')
    rescue KeyError => e
      raise ConfigError.new("QUBE_WEBHOOK_SECRET not set in environment. Your webhook secret can be found/copied from your application page on https://qubesync.com/.")
    end
  
    def sign_payload(payload)
      OpenSSL::HMAC.hexdigest('sha256', api_secret, payload)
    end
  
    # Verifies a webhook against its `X-QUBE-Signature` header and returns the
    # parsed body. `body` must be the raw request body, unparsed. The timestamp
    # must be within `max_age` seconds of now, either way.
    def verify_and_build_webhook!(body, signature, max_age: 300)
      meta = extract_signature_meta(signature)

      age = Time.now.to_i - meta[:timestamp]
      if age.abs > max_age
        when_sent = age.positive? ? "#{age} seconds old" : "#{-age} seconds in the future"
        raise StaleWebhookError.new("Webhook timestamp is #{when_sent}; it must be within #{max_age} seconds of now. Check this server's clock.")
      end

      expected = sign_payload("#{meta[:timestamp]}.#{body}")
      if meta[:signatures].any? { |sig| secure_compare(expected, sig) }
        JSON.parse(body)
      else
        raise InvalidWebhookSignatureError.new("Webhook signature mismatch")
      end
    end

    # Constant-time string comparison, so a mismatch takes as long wherever it is.
    def secure_compare(a, b)
      return false unless a.bytesize == b.bytesize

      OpenSSL.fixed_length_secure_compare(a, b)
    end
end
