# QUBESync

A simple wrapper around the QUBE Sync API.

## Installation

Requires Ruby 3.3 or newer.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add qube_sync

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install qube_sync

## Configuration

You'll need to set two evironment variables in your application to use this gem:

`QUBE_API_KEY` - This is your API key, which you can find in your QUBE Sync application's settings.
`QUBE_WEBHOOK_SECRET` - This is the secret key used to sign the webhook payloads. You can find this in your QUBE Sync application's settings.

## Usage

```ruby
require 'qube_sync'

connection_id = QubeSync.create_connection # creates a connection in QUBE on behalf of your user
#=> "636d4750-0b07-45f6-a030-e3919c5741ff"


QubeSync.delete_connection("asdf-qwer-asdf-zxcv") # deletes the connection in QUBE
#=> true

QubeSync.get_connection(connection_id) # gets the connection in QUBE
#=> {"id"=>"636d4750-0b07-45f6-a030-e3919c5741ff"}

QubeSync.generate_password(connection_id)
#=> "password123"

QubeSync.get_qwc(connection_id)
# "<?xml version=\"1.0\"?>\n<QBWCXML>...</QBWCXML>\n"

# Using the RequestBuilder to build a Quickbooks Request (generates JSON for QubeSync to translate)
request_json = QubeSync::RequestBuilder.new do |b|
  b.QBXML {
    b.QBXMLMsgsRq(onError: "stopOnError") {
      b.CustomerQueryRq(requestID: 1) {
        b.MaxReturned(10)
      }
    }
  }
end

QubeSync.queue_request(connection_id, {request_json: request_json, webhook_url: "myapp.com/webhook"})

# Using XML directly
request_xml = <<~XML
  <?xml version="1.0"?>
  <?qbxml version="16.0"?>
  <QBXML>
    <QBXMLMsgsRq onError="stopOnError">
      <CustomerQueryRq requestID="1">
        <MaxReturned>10</MaxReturned>
      </CustomerQueryRq>
    </QBXMLMsgsRq>
  </QBXML>
XML

QubeSync.queue_request(connection_id, {request_xml: request_xml, webhook_url: "myapp.com/webhook"})
#=> {"id"=>"d401228f-06d4-4981-95d8-bb735c0a2c76",
#    "state"=>"waiting",
#    "response_xml"=>nil,
#    "webhook_url"=>"myapp.com/webhook",
#    "request_xml"=>
#     "<?xml version=\"1.0\"?><?qbxml version=\"16.0\"?><QBXML>  ...  </QBXMLMsgsRq></QBXML>"}}

request_id = _.fetch("id")

QubeSync.get_request(request_id)
#=> {"id" => "d401228f-06d4-4981-95d8-bb735c0a2c76",
#    "state" => "webhook_succeeded",
#    "response_xml" =>
#      "<?xml version=\"1.0\" ?> <QBXML> <QBXMLMsgsRs> ... </QBXMLMsgsRs> </QBXML>",
#    "response_json" => [
#      "CustomerQueryRs" => {
#        "requestID"=>"1",
#        "statusCode"=>"0",
#        "statusSeverity"=>"Info",
#        "statusMessage"=>"Status Message",
#        "Results" => [
#          {"Name"=>"Customer 1", "ListID"=>"123"},
#          {"Name"=>"Customer 2", "ListID"=>"456"}
#         ]
#       },
#    ],
#    "webhook_url" => "myapp.com/webhook",
#    "request_xml" =>
#      "<?xml version=\"1.0\"?><?qbxml version=\"16.0\"?><QBXML>  ...  </QBXMLMsgsRq></QBXML>"}}

QubeSync.get_requests(connection_id)
#=> [{"id"=>"d401228f-06d4-4981-95d8-bb735c0a2c76",
#     "state"=>"webhook_succeeded",
#     "response_xml"=>
#      "<?xml version=\"1.0\" ?> <QBXML> <QBXMLMsgsRs> ... </QBXMLMsgsRs> </QBXML>",
#     "webhook_url"=>"myapp.com/webhook",
#     "request_xml"=>
#      "<?xml version=\"1.0\"?><?qbxml version=\"16.0\"?><QBXML>  ...  </QBXMLMsgsRq></QBXML>"}]

QubeSync.delete_request(request_id)
#=> true

QubeSync.verify_and_build_webhook!(request.body.read, request.headers['X-Qube-Signature'])
#=> {
#  "id"=>"dd8db40a-5169-477a-b9d5-f1a6e5cc96f9",
#  "timestamp"=>1738620998,
#  "response_json"=> {...},
#  "response_xml"=>
#   "<?xml version=\"1.0\" ?> <QBXML> <QBXMLMsgsRs> ... </QBXMLMsgsRs> </QBXML>" 
# }

# Pass the raw request body, before anything parses it. A bad or missing signature raises
# QubeSync::InvalidWebhookSignatureError; answer 401.
#
# The timestamp must be within 300 seconds (5 minutes) of now, either way, or it raises
# QubeSync::StaleWebhookError. max_age (in seconds) sets another window:
QubeSync.verify_and_build_webhook!(request.body.read, request.headers['X-Qube-Signature'], max_age: 120)
```

## Webhooks

`QubeSync::Webhooks` verifies a delivery's `X-QUBE-Signature` header and parses the body into a
typed event. It doesn't need Rails or Rack, and never reads the environment: pass it the raw body,
the header and your webhook secret.

```ruby
require "qube_sync"

# raw_body: the request body exactly as received, before anything parses it.
# header:   the X-QUBE-Signature header (nil when it's absent).
def handle_qube_webhook(raw_body, header)
  event = QubeSync::Webhooks.verify(raw_body, header, secrets: ENV.fetch("QUBE_WEBHOOK_SECRET"))

  case event.type
  when "request"
    # A queued request's answer. Deduplicate on event.dedupe_key ("<page_request_id>:<state>").
    # event.response_json, event.error, event.page, event.iteration_state
  when "workflow_run"
    # A run is waiting for an answer, or has ended. Skip it unless event.newer_than?(stored)
    # for the revision stored with event.reference: deliveries can arrive out of order.
    # event.awaiting_input? / completed? / failed? / cancelled?, event.prompt, event.output
  when "notification"
    # Data a running workflow sent. Deduplicate on event.dedupe_key (the delivery_id), and
    # never skip one by revision. event.name, event.data
  when "connection"
    # Connected, setup cancelled, stalled or resumed. Deduplicate on event.dedupe_key, and skip
    # it unless event.newer_than?(the revision stored for event.connection_id).
  when "name_index"
    # event.connection_id, event.name_index
  else
    # An event this version doesn't know yet: acknowledge it.
  end

  200
rescue QubeSync::Webhooks::SignatureError => e
  # e.reason is :missing, :malformed, :stale or :mismatch. The message is safe to log.
  warn "QuBe Sync webhook refused: #{e.message}"
  401
end
```

- `secrets:` takes one secret or a list. While a secret rotates, a delivery carries one `v1`
  signature per active secret, and either secret verifies it.
- The timestamp must be within 300 seconds of now, either way. `tolerance:` (seconds) sets
  another window, and `now:` (unix seconds or a `Time`) sets the clock, for tests.
- Every event has `type`, `event`, `timestamp`, `app_id`, `sandbox`, `dedupe_key` and `to_h`
  (the whole body). A missing key reads as `nil`, and `event["any_key"]` reads any other key.
- `QubeSync::Webhooks.parse(raw_body)` builds the event without verifying it, for tests or for
  code that verified the delivery elsewhere.

In Rails, read the raw body with `request.raw_post`:

```ruby
class QubeWebhooksController < ActionController::API
  def create
    event = QubeSync::Webhooks.verify(
      request.raw_post,
      request.headers[QubeSync::Webhooks::HEADER],
      secrets: Rails.application.credentials.qube_webhook_secret
    )
    QubeWebhookJob.perform_later(event.to_h) # route by type in the job, as above
    head :ok
  rescue QubeSync::Webhooks::SignatureError => e
    Rails.logger.warn("QuBe Sync webhook refused: #{e.message}")
    head :unauthorized
  end
end
```

`QubeSync.verify_and_build_webhook!` (0.2.4) still works, and still returns the parsed Hash.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qubeintegrations/qube_sync.
