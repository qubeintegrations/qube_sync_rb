## [Unreleased]

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
