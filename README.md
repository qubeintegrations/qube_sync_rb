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
`update_connection(id, webhook_url:, name:)` changes either. `create_connection(webhook_url:,
type: "simulated")` makes a connection to a simulated QuickBooks company file instead, connected
as it's made, for testing without a Windows computer. `get_connection`,
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

### Typed workflow starts

`qube_sync workflows` fetches your app's workflow input types (`GET /api/v2/workflows/types`) and
writes them as Ruby and RBS you check in: a start method per workflow, and per branch of its
input, whose operation bodies have the same types and field docs as the operation methods below.

```sh
QUBE_API_KEY=... bundle exec qube_sync workflows             # lib/qube_workflows.rb, sig/qube_workflows.rbs
QUBE_API_KEY=... bundle exec qube_sync workflows --check     # in CI: exits 1 when the files are out of date
```

```ruby
require_relative "qube_workflows"
QubeWorkflows.client = QUBE # once, at boot

QubeWorkflows.add_transaction.invoice(connection_id, {
  customer_ref: {list_id: "80000001-1700000000"},
  invoice_line_add: [{item_ref: {full_name: "Consulting"}, amount: "100.00"}]
}, adds: [{kind: "customer", add: {name: "Acme Ltd"}}],
  reference: "invoice-#{invoice.id}", webhook_url: "https://myapp.example/qube/runs")

# The input alone, for start or a QubeRails::Operation's input:
QubeWorkflows.add_transaction.invoice_input(params, adds: adds)
```

- A workflow whose input has branches (add_transaction's `operation`, upsert's `kind`) gets one
  method per branch, named by the branch: the discriminator is filled in and the inputs are
  keywords (required ones without defaults), except a workflow's one operation body (add_transaction's
  `params`), which every branch takes positionally; a workflow with two (upsert's `add` and
  `update`) takes both as keywords. `start(connection_id, input, ...)` takes any branch's input. A workflow without
  branches gets `start(connection_id, <inputs as keywords>, reference:, webhook_url:)` and
  `input(...)`. Each `*_input` leaves out nil values. `connection_id` may be anything with a
  `qube_id` (a QubeRails::Connection).
- Each start takes `reference:`, `webhook_url:`, `version: nil` and `client:` (QubeWorkflows.client
  unless given), and returns the run as `start_run` does.
- The RBS gives each input a type alias (`QubeWorkflows::AddTransaction::invoice_input`), each
  operation body that operation's params record (`::QubeSync::Operations::Invoice::create_params`)
  and a nested entry with branches (an `adds` item) a union of a record per branch. An operation
  newer than your qube_sync is a plain Hash, with a warning when the served operations aren't the
  gem's. A field the workflow sets itself (QuBe Sync lists them as `set_by_workflow`: upsert's
  `list_id` and `edit_sequence`) is optional in that body, which then gets a record of its own
  (`payment_body`, `customer_update_body`), and its docs say a value given for it is overwritten.
- QuBe Sync still checks every start: a field the operation doesn't take is a 422 at the call, its
  error's `path` the body (`input.params`) and its `message` naming the field (`unknown parameter:
  "customer_rf"`).
- `--drafts` types each workflow's draft where it has one, so you can build against a workflow
  before publishing it. The header records the digest and the flag, and `--check` fetches with the
  same flag. When QuBe Sync can't be reached or answers 5xx, `--check` warns and exits 0; a 401
  exits 1.
- `--output PATH` and `--sig PATH` choose the files; `QUBE_BASE_URL` another host.
- In Rails, `bin/rails g qube_rails:workflows` (qube_rails) writes the same file into `app/qube/`.

### Queueing an operation

Every QuickBooks operation is a method on its entity: `client.<entity>.<action>`, where the
action is `create`, `update`, `query`, `delete` or `execute`.

```ruby
hook = "https://myapp.example/qube/requests"

request = QUBE.customer.create(connection_id, {
  name: "Acme Ltd",
  bill_address: {addr1: "1 Main St", city: "Austin", state: "TX"}
}, webhook_url: hook)

# A query sends its filters as the query string; nested filters are fine.
QUBE.invoice.query(connection_id, {
  modified_date_range_filter: {from_modified_date: "2026-10-01T00:00:00"},
  include_line_items: true,
  iterator: true, max_returned: 50 # pages of 50, each its own webhook
}, webhook_url: hook)

QUBE.txn_void.execute(connection_id, {txn_void_type: "Invoice", txn_id: "1A2-1700000000"}, webhook_url: hook)

# qbXML as written.
QUBE.queue_qbxml(connection_id, request_xml, webhook_url: hook)
```

- Each method is `(connection_id, params = {}, webhook_url:, idempotency_key: nil)` and returns
  the queued request. Its documentation (YARD, in `lib/qube_sync/operations/<entity>.rb`) lists
  every field, nested ones included, says whether QuickBooks answers in pages, and links the API
  reference. The params' types are RBS records in `sig/qube_sync/operations/`, for Steep or an
  editor that reads RBS.
- An entity's file loads the first time you use it, so `require "qube_sync/client"` stays quick.
- QuickBooks' `class` entity is `client.class_` (`client.class` is Ruby's).
- `queue(operation_id, connection_id, params = {}, webhook_url:, idempotency_key: nil)` queues one
  by its id: `QUBE.queue("customer.create", connection_id, {name: "Acme Ltd"}, webhook_url: hook)`
  sends the same request as `QUBE.customer.create`. For an operation newer than your version of
  the gem, pass `method:` and `path:` (relative to the connection):
  `QUBE.queue("widget.create", connection_id, params, webhook_url: hook, method: :post, path: "widgets")`.
- A query string repeats an array's key (`list_id=1&list_id=2`) and brackets nested Hashes
  (`name_range_filter[from_name]=A`, `currency_filter[list_id][]=1`), as the API reads them.

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
