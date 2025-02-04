# frozen_string_literal: true

RSpec.describe QubeSync do
  before(:all) do
    ENV["QUBE_API_KEY"] = "test"
    ENV["QUBE_WEBHOOK_SECRET"] = "secret"
  end

  it "has a version number" do
    expect(QubeSync::VERSION).not_to be nil
  end

  describe "#verify_and_build_webhook!" do
    it "raises an error if the timestamp is older than max_age" do
      old_timestamp = Time.now.to_i - 501
      body = "test"
      signature = "timestamp=#{old_timestamp},signature=1234"
      expect { QubeSync.verify_and_build_webhook!(body, signature) }.to raise_error(QubeSync::StaleWebhookError)
    end

    it "raises an error if the signature is invalid" do
      body = "test"
      signature = "timestamp=#{Time.now.to_i},signature=1234"
      expect { QubeSync.verify_and_build_webhook!(body, signature) }.to raise_error(QubeSync::InvalidWebhookSignatureError)
    end

    it "returns the body if the signature is valid" do
      body = "{\"test\": \"test\"}"
      valid_signature = OpenSSL::HMAC.hexdigest('sha256', ENV["QUBE_WEBHOOK_SECRET"], body)
      signature = "timestamp=#{Time.now.to_i},signatures=fake_2nd_signature,#{valid_signature}"
      expect(QubeSync.verify_and_build_webhook!(body, signature)).to eq(JSON.parse(body))
    end
  end

end
