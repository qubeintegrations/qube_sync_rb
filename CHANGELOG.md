## [Unreleased]

## [0.5.0] - 2026-10-27

Typed workflow starts, simulated connections, resending a run's latest event, and per-row search. Nothing
existing changes: every 0.4.0 call works as it did.

### New

- **Typed workflow starts.** `bundle exec qube_sync workflows` (with `QUBE_API_KEY` set) fetches
  your app's workflow input types from QuBe Sync and writes `lib/qube_workflows.rb` and its RBS
  (`sig/qube_workflows.rbs`): a start method and an `*_input` builder for each branch of each
  workflow's input, with every operation body typed as that operation's params
  (`QubeSync::Operations::<Entity>::<action>_params`) and linked to its YARD reference. Fields a
  workflow sets itself (`set_by_workflow`) are optional in its bodies. Options: `--drafts`,
  `--output`, `--sig`, and `--check`, which exits 1 when your file no longer matches what QuBe
  Sync serves (naming the workflows that changed) or on a 401, and warns but exits 0 when QuBe
  Sync can't be reached. The same input always gives byte-identical files, and the generated
  file loads on Ruby 2.7 too. `QubeSync::WorkflowTypes.render` and `.check` do the same from
  code; qube_rails' generator uses them.
- `Client#workflow_types(include_drafts: false, etag: nil)`: `GET /workflows/types`, returning
  `:not_modified` on a 304.
- `Client#create_connection(webhook_url:, name: nil, type: nil)`: `type: "simulated"` makes a
  connection to a simulated QuickBooks company file, connected as soon as it's made, for trying
  an integration without QuickBooks Desktop.
- `Client#redeliver_run(connection_id, run_id)`: `POST .../workflow-runs/{id}/redeliver` has
  QuBe Sync send the run's latest event to your webhook again, for when your endpoint was down
  longer than QuBe Sync's retries.
- `search(search_url, field:, q:, row: nil)`: `row` names the row of a question's rows field,
  for a search whose kind depends on that row (the missing-records question's per-record search).
- `QubeSync::Operations::DIGEST`: the sha256 of the QuickBooks operations manifest this version
  was generated from. `qube_sync workflows` warns when QuBe Sync's operations differ from it,
  since operations this version doesn't know are typed as a plain Hash.

### Changed

- The per-operation docs now say a QuickBooks `list_id` is unique within a list family, not
  across the company file: customers, vendors, employees and other names share one sequence,
  every item type shares another, and each other list has its own. Key stored ids by
  connection and record kind, never by `list_id` alone.

## [0.4.0] - 2026-10-25

Adds `QubeSync::Client`, a client for the v2 API. Nothing existing changes: the v1 module
functions still call `/api/v1` and read `QUBE_API_KEY` and `QUBE_URL`, and are now documented as
legacy (no runtime warning). New code should use the client.

- `QubeSync::Client.new(api_key:, base_url: "https://qubesync.com", open_timeout: 5,
  read_timeout: 30, max_retries: 2, total_timeout: 60, on_retry: nil)`. It takes the key as an argument and never reads the
  environment, sends it as Basic auth, and never shows it in `inspect`. `require
  "qube_sync/client"` loads it alone, on the standard library (Net::HTTP), without Faraday.
- Connections: `create_connection`, `get_connection`, `list_connections`, `update_connection`,
  `delete_connection`, `regenerate_onboarding`, `set_password`, `get_qwc`.
- Runs and questions: `start_run` (its `reference` is the Idempotency-Key), `get_run`,
  `list_runs`, `cancel_run`, `run_events`, `answer`, `search`. Methods that take a link refuse
  one on another scheme, host or port with `ArgumentError`, before any request.
- QuickBooks operations: one method per operation on its entity, `client.customer.create`,
  `client.invoice.query`, `client.txn_void.execute`... (261 operations on 124 entities;
  QuickBooks' `class` is `client.class_`), each `(connection_id, params = {}, webhook_url:,
  idempotency_key: nil)`. They're generated from the QuickBooks operations manifest
  (`spec/fixtures/operations.json`, served at https://qubesync.com/libraries/operations.json)
  by `bin/generate-operations` (`rake operations:generate`), with YARD docs listing every field
  and RBS records for the params in `sig/qube_sync/operations/`. An entity's file loads on first
  use. CI fails when the generated files or the vendored manifest drift.
- `queue(operation_id, connection_id, params = {}, webhook_url:, idempotency_key: nil, method:
  nil, path: nil)` queues an operation by its id; `method:` and `path:` send one this version
  doesn't know. A query string repeats an array's key and brackets nested Hashes.
- Requests: `queue_qbxml`, `get_request`, `request_pages`, `list_requests`, `each_request`
  (every page), `discard_request`; and `request` for anything else. Operations and
  `queue_qbxml` make an Idempotency-Key per call when none is given, and reuse it on that call's
  retries.
- Signatures for the whole client in `sig/` (`rbs -I sig validate` runs in CI).
- Retries: a GET, PUT, DELETE or a request with an Idempotency-Key is retried twice (0.5 s, then
  1 s) on a failed connection, a timeout, or a 429, 502, 503 or 504, honouring `Retry-After` up
  to 30 s. `answer` is retried too when its link has a `prompt_token`. Anything else outside 2xx
  raises `QubeSync::APIError` (a `QubeSync::Error`) with `status`, `errors`, `code`, `message`,
  `body` and `request_id`.
- A call returns or raises within `total_timeout` (60 s), retries and their waits included: each
  attempt's timeouts are cut to the time left, and no retry is made unless a second is left after
  its wait.
- `on_retry:` is called before each retry's wait with a frozen Hash (`attempt`, `max_retries`,
  `delay`, `elapsed`, `method`, `url` without its query, `status`, `error`); an exception it
  raises stops the call.
- A retried DELETE that gets a 404 after an earlier attempt's answer was lost (a read timeout, a
  reset or closed connection, a 502 or 504) returns nil, as a 204 would.

## [0.3.0] - 2026-10-23

Adds `QubeSync::Webhooks`, which verifies a delivery and parses it into a typed event. Nothing
existing changes: `verify_and_build_webhook!` works as it did in 0.2.4.

- `QubeSync::Webhooks.verify(raw_body, header, secrets:, tolerance: 300, now: Time.now)` checks
  the `X-QUBE-Signature` header and returns an event, or raises
  `QubeSync::Webhooks::SignatureError` (a `QubeSync::Error`) whose `reason` is `:missing`,
  `:malformed`, `:stale` or `:mismatch`. It takes the secret as an argument, one or a list while
  a secret rotates, and never reads the environment. Its messages never hold the secret, a
  signature or the body.
- Passing a parsed body raises `TypeError`, and an empty list of secrets raises `ArgumentError`.
  A body that verifies but isn't a JSON object raises `QubeSync::Webhooks::ParseError`.
- `QubeSync::Webhooks.parse(raw_body)` (or `Event.from_json`) builds the event without
  verifying.
- One event class per type: `RequestEvent`, `WorkflowRunEvent`, `NotificationEvent`,
  `ConnectionEvent`, `NameIndexEvent` and `UnknownEvent` (never refused). Each has `type`,
  `event`, `timestamp`, `app_id`, `sandbox`, `dedupe_key`, `to_h` and `[]`; a missing key reads
  as `nil`. Workflow runs and connections have `newer_than?(stored_revision)`. Notifications
  don't, because they're never skipped by revision.
- Specs run every case in `spec/fixtures/test_vectors.json`, generated by the QuBe Sync server.

## [0.2.4] - 2026-10-22

Security fixes for webhook verification. Upgrading needs no code change, but needs Ruby 3.3 or
newer.

- Requires Ruby 3.3 or newer (the oldest Ruby still supported) and Faraday 2.14.3 or newer, which
  fixes GHSA-98m9-hrrm-r99r, GHSA-33mh-2634-fwr2 and GHSA-5rv5-xj5j-3484. 0.2.3 allowed Ruby 2.6
  and any Faraday 2.

- `verify_and_build_webhook!` verifies real deliveries: it signs `"<t>.<raw body>"` as the
  server does and reads `t` and every `v1` from `X-QUBE-Signature` by key. 0.2.3 signed the body
  alone and compared against the `v1=`-prefixed parts, so no real delivery verified.
- Signatures are compared in constant time (`OpenSSL.fixed_length_secure_compare`), not with
  `==`.
- The timestamp must be within 300 seconds of now, either way. It was 500 seconds old, and any
  timestamp in the future passed. `max_age` (seconds) still sets the window.
- A missing or malformed header raises `InvalidWebhookSignatureError`, not `NoMethodError`.
- The stale error says how old (or how far ahead) the timestamp was; it used to print
  `#{max_age}ms` literally.
- `RequestBuilder` sends `true` and `false` as the text `"true"` and `"false"`. 0.2.3 dropped
  them, so `b.IsActive true` went out as an empty `<IsActive/>`.
- Specs run against a delivery signed by the QuBe Sync server (`spec/fixtures/webhook_vectors.json`).

## [0.1.0] - 2025-01-31

- Initial release
