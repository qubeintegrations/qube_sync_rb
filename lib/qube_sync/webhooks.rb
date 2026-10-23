# frozen_string_literal: true

require "json"
require "openssl"

module QubeSync
  class Error < StandardError; end

  # Verifies QuBe Sync webhook deliveries and parses them into typed events.
  #
  #   event = QubeSync::Webhooks.verify(raw_body, header, secrets: ENV.fetch("QUBE_WEBHOOK_SECRET"))
  #
  # Framework-free: it never reads the environment or a request object. Pass the raw request body
  # as received and the value of the `X-QUBE-Signature` header.
  module Webhooks
    # The header that carries the signature, and its name in a Rack env.
    HEADER = "X-QUBE-Signature"
    RACK_HEADER = "HTTP_X_QUBE_SIGNATURE"

    # Seconds a delivery's timestamp may be from now, either way.
    DEFAULT_TOLERANCE = 300

    REASONS = %i[missing malformed stale mismatch].freeze

    # A delivery that failed verification. Answer it with 401. `reason` is one of
    # `:missing`, `:malformed`, `:stale`, `:mismatch`. The message is safe to log: it never holds
    # a secret, a signature or the body.
    class SignatureError < QubeSync::Error
      attr_reader :reason

      def initialize(reason, message = nil)
        @reason = reason
        super(message || default_message(reason))
      end

      private

      def default_message(reason)
        case reason
        when :missing then "No #{HEADER} header"
        when :malformed then "Malformed #{HEADER} header: expected t=<unix seconds>,v1=<hex>"
        when :stale then "Webhook timestamp is outside the tolerance"
        when :mismatch then "Webhook signature doesn't match any of the given secrets"
        else "Webhook signature is invalid (#{reason})"
        end
      end
    end

    # A body that verified (or was handed to `parse`) but isn't a JSON object.
    class ParseError < QubeSync::Error; end

    module_function

    # Verifies a delivery and returns its typed event (see `parse`). Raises SignatureError when
    # the header is missing, malformed, stale or matches none of `secrets`.
    #
    # - `raw_body`: the request body as received (a String), before anything parses it.
    # - `header`: the `X-QUBE-Signature` value (nil when absent).
    # - `secrets:`: the app's webhook secret, or a list of them while one rotates.
    # - `tolerance:`: seconds the timestamp may be from `now`, either way.
    # - `now:`: unix seconds, or a Time.
    def verify(raw_body, header, secrets:, tolerance: DEFAULT_TOLERANCE, now: Time.now)
      raw_body = raw_body!(raw_body)
      secrets = secrets!(secrets)
      now = unix_seconds!(now)

      header = header.to_s.b.strip
      raise SignatureError.new(:missing) if header.empty?

      timestamp, signatures = parse_header(header)

      age = now - timestamp.to_i
      if age.abs > tolerance
        when_sent = age.positive? ? "#{age} seconds old" : "#{-age} seconds in the future"
        raise SignatureError.new(
          :stale,
          "Webhook timestamp is #{when_sent}; it must be within #{tolerance} seconds of now. Check this server's clock."
        )
      end

      signed = "#{timestamp}.".b + raw_body.b
      expected = secrets.map { |secret| OpenSSL::HMAC.hexdigest("sha256", secret, signed) }
      matched = expected.product(signatures).any? { |exp, sig| secure_compare(exp, sig) }
      raise SignatureError.new(:mismatch) unless matched

      parse(raw_body)
    end

    # Builds the typed event from a raw body without verifying it: for tests, and for code that
    # verified the delivery elsewhere.
    def parse(raw_body)
      raw_body = raw_body!(raw_body)
      text = raw_body.encoding == Encoding::UTF_8 ? raw_body : raw_body.dup.force_encoding(Encoding::UTF_8)

      body =
        begin
          JSON.parse(text)
        rescue JSON::ParserError, EncodingError
          raise ParseError, "Webhook body isn't valid JSON"
        end
      raise ParseError, "Webhook body isn't a JSON object" unless body.is_a?(Hash)

      Event.build(body)
    end

    # Splits the header into its `t` and its non-empty `v1`s, or raises :malformed.
    def parse_header(header)
      timestamp = nil
      signatures = []

      header.split(",").each do |part|
        key, value = part.strip.split("=", 2)
        next if value.nil?

        case key
        when "t" then timestamp ||= value
        when "v1" then signatures << value unless value.empty?
        end
      end

      unless timestamp&.match?(/\A[0-9]+\z/) && !signatures.empty?
        raise SignatureError.new(:malformed)
      end

      [timestamp, signatures]
    end

    # Constant-time comparison of two byte strings; different lengths are simply false.
    def secure_compare(a, b)
      a = a.b
      b = b.b
      return false unless a.bytesize == b.bytesize

      OpenSSL.fixed_length_secure_compare(a, b)
    end

    def raw_body!(raw_body)
      return raw_body if raw_body.is_a?(String)

      raise TypeError,
            "Pass the raw request body as a String (in Rails, request.raw_post), not a #{raw_body.class}: " \
            "the signature covers the exact bytes QuBe Sync sent"
    end

    def secrets!(secrets)
      list = secrets.is_a?(String) ? [secrets] : Array(secrets)
      raise ArgumentError, "secrets is empty: pass the app's webhook secret" if list.empty?
      unless list.all? { |secret| secret.is_a?(String) && !secret.empty? }
        raise ArgumentError, "each secret must be a non-empty String"
      end

      list
    end

    def unix_seconds!(now)
      case now
      when Integer then now
      when Time then now.to_i
      when Numeric then now.floor
      else
        return now.to_time.to_i if now.respond_to?(:to_time)

        raise ArgumentError, "now must be unix seconds or a Time, not a #{now.class}"
      end
    end

    private_class_method :parse_header, :secure_compare, :raw_body!, :secrets!, :unix_seconds!
  end
end

require_relative "webhooks/event"
