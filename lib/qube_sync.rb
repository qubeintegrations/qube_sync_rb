require_relative "qube_sync/version"
require_relative "qube_sync/request_builder"
require "faraday"

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
  
  
    def extract_signature_meta(header)
      header.split(',') => [ts, *signatures]
      {
        timestamp: ts.split("=").last.to_i,
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
  
    def verify_and_build_webhook!(body, signature, max_age: 500)
      extract_signature_meta(signature) => { timestamp:, signatures:}
  
      if timestamp < Time.now.to_i - max_age
        raise StaleWebhookError.new('Timestamp more than #{max_age}ms old. To increase this, pass a different value for max_age.')
      end
      
      if signatures.detect { |sig| sign_payload(body) == sig }
        JSON.parse(body)
      else
        raise InvalidWebhookSignatureError.new("Webhook signature mismatch")
      end
  
    end
end
