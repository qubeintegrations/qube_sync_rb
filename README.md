# QUBESync

The Ruby library for the [QuBe Sync](https://qubesync.com) API: a client for the v2 API, and
webhook verification. The API's docs are at https://docs.qubesync.com.

## Installation

Requires Ruby 3.3 or newer.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add qube_sync

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install qube_sync

## The v2 client

`QubeSync::Client` calls the v2 API. Make one from your app's configuration: it never reads the
environment itself, so one app can hold a sandbox and a production client at once.

```ruby
require "qube_sync" # or require "qube_sync/client" alone: it uses only the standard library

QUBE = QubeSync::Client.new(api_key: ENV.fetch("QUBE_API_KEY"))
```

`base_url:` (default `"https://qubesync.com"`), `open_timeout:` (5 s), `read_timeout:` (30 s),
`max_retries:` (2), `total_timeout:` (60 s) and `on_retry:` are options (see Retries below). Every method returns the response's `data`, a plain Hash or Array
with String keys, and nil for an empty answer.

### Onboarding a customer

```ruby
connection = QUBE.create_connection(webhook_url: "https://myapp.example/qube/connections", name: "Acme Ltd")
customer.update!(qube_connection_id: connection["id"])

redirect_to connection["links"]["onboarding"], allow_other_host: true
```

QuBe Sync sends `connection.connected` to the connection's `webhook_url` once the customer's Web
Connector first checks in. `regenerate_onboarding(id)` makes a fresh onboarding link, and
`update_connection(id, webhook_url:, name:)` changes either. `get_connection`,
`list_connections`, `delete_connection`, `set_password(id, password: nil)` and `get_qwc(id)` (the
QWC file's XML) are there for setup without hosted onboarding.

### Starting a run and answering its question

```ruby
run = QUBE.start_run(
  connection_id, "sync_customer", {"customer" => {"name" => "Acme Ltd"}},
  reference: "customer-#{customer.id}",          # also sent as the Idempotency-Key
  webhook_url: "https://myapp.example/qube/runs"
)

# Later, a workflow_run webhook says the run is awaiting input. Its links are the run's own:
event = QubeSync::Webhooks.verify(raw_body, header, secrets: ENV.fetch("QUBE_WEBHOOK_SECRET"))
if event.awaiting_input?
  matches = QUBE.search(event.links["search"], field: "customer", q: "Acme") # a record field's choices
  QUBE.answer(event.links["decisions"], choice: "rename", data: {"name" => "Acme Ltd (2)"})
end
```

`get_run(run_url)` or `get_run(connection_id, run_id)` reads a run, `list_runs(connection_id,
reference:, state:, outcome:)` finds runs, `cancel_run(cancel_url, reason: nil)` cancels one, and
`run_events(connection_id, run_id, after:, limit:)` returns a page of its event log whole
(`{"data" => [...], "next_after" => ...}`). A method that takes a link takes it from a webhook's
or a run's `links`, or a path under `/api/v2`. A link on any other scheme, host or port raises
`ArgumentError` before a request is made, so the API key only ever goes to QuBe Sync.

### Queueing an operation

```ruby
request = QUBE.queue(connection_id, "customers", {name: "Acme Ltd"},
  webhook_url: "https://myapp.example/qube/requests")

# A query: method: :get sends the filters as the query string.
QUBE.queue(connection_id, "invoices", {max_returned: 100, iterator: "Start"},
  webhook_url: "https://myapp.example/qube/requests", method: :get)

# qbXML as written.
QUBE.queue_qbxml(connection_id, request_xml, webhook_url: "https://myapp.example/qube/requests")
```

The answer comes to `webhook_url` (see Webhooks below). `get_request(connection_id, id)`,
`request_pages(connection_id, id)` and `discard_request(connection_id, id)` act on one request.
`list_requests(connection_id, page:, page_size:, state:, ...)` returns a page whole (`{"data" =>
[...], "meta" => {"page" => 1, "total_pages" => 3}}`), and `each_request(connection_id, **filters)`
yields every request on every page (an Enumerator without a block).

`request(method, path_or_url, body = nil, query: {}, headers: {})` calls anything else and returns
the whole parsed body.

### Retries, idempotency and errors

- A GET, PUT or DELETE, or any request with an `Idempotency-Key`, is retried up to `max_retries`
  times (after 0.5 s, then 1 s) when the connection fails or times out, or QuBe Sync answers 429,
  502, 503 or 504. A `Retry-After` on a 429 or 503 is honoured, up to 30 s. Other requests
  (`create_connection`, `cancel_run`...) are sent once.
- A call returns or raises within `total_timeout` (60 s), retries and their waits included: each
  attempt's timeouts are cut to the time left, and a retry is made only when at least a second
  would be left after its wait (a `Retry-After` that doesn't fit isn't waited, nor shortened; the
  call raises what the last attempt got). Pass `max_retries: 0` for calls made while a user waits
  on a page, if 60 s is too long.
- `answer` is retried when its link has a `prompt_token`, as a run's `links.decisions` always
  does while it asks. A retry after a lost answer may raise a 409 with code `prompt_changed`:
  the question has been answered, by the first attempt or by someone else. Without a
  `prompt_token` it's sent once, since an answer sent again could be taken for the run's next
  question.
- A retried DELETE (`delete_connection`, or `request(:delete, ...)`) that gets a 404 returns nil,
  as a 204 would, when an earlier attempt's answer was lost after the request could have reached
  QuBe Sync (a read timeout, a connection reset or closed, a 502 or 504): that attempt deleted it.
  Any other 404 raises, including a retry's after a refused connection, a connect timeout, a 429
  or a 503.
- `on_retry:` takes a callable, called before each retry's wait with a frozen Hash: `attempt`
  (1, 2...), `max_retries`, `delay` and `elapsed` (seconds), `method`, `url` (without its query
  string), `status` (for a status retry) and `error` (for a network failure), and never the key,
  headers or body. It isn't called when no retry is made. An exception it raises stops the call
  and reaches the caller.

  ```ruby
  QubeSync::Client.new(api_key: ENV.fetch("QUBE_API_KEY"),
    on_retry: ->(r) { Rails.logger.warn("QuBe Sync retry #{r[:attempt]}/#{r[:max_retries]} #{r[:method]} #{r[:url]} #{r[:status] || r[:error].class}") })
  ```
- `start_run` sends `reference` as the Idempotency-Key. `queue` and `queue_qbxml` take
  `idempotency_key:`; without one the client makes a UUID per call and sends it again on that
  call's retries, so a retry never queues a request twice.
- Any other answer outside 2xx raises `QubeSync::APIError` (a `QubeSync::Error`): `status`,
  `errors` (the body's `errors` as parsed), `code` (`errors["code"]`, such as `prompt_changed`, or
  nil), `message` (one line, safe to log), `body` and `request_id` (the `x-request-id` header, for
  support). A connection that still fails after the retries raises Ruby's own error
  (`Net::OpenTimeout`, `Net::ReadTimeout`, `Errno::ECONNREFUSED`...).
- The API key never appears in an error or in `inspect`.

```ruby
begin
  QUBE.answer(decisions_url, choice: "rename")
rescue QubeSync::APIError => e
  raise unless e.code == "prompt_changed" # the question changed: show the new one
  refresh_question(run)
end
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

## v1 (legacy)

The v1 module functions below call `/api/v1` and still work, but the v2 client above is the one to
use for new code.

### Configuration

You'll need to set two evironment variables in your application to use this gem:

`QUBE_API_KEY` - This is your API key, which you can find in your QUBE Sync application's settings.
`QUBE_WEBHOOK_SECRET` - This is the secret key used to sign the webhook payloads. You can find this in your QUBE Sync application's settings.

### Usage

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qubeintegrations/qube_sync_rb.
