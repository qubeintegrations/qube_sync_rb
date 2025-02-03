# QUBESync

The QUBESync API is very simple, so this gem is not necessary if you need to use older versions of Ruby or if you prefer to write your own API client. However, if you are using Ruby 2.6 or later and you want to save time, this gem can help you.

## Installation

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

QubeSync.create_connection # creates a connection in QUBE on behalf of your user
#=> "asdf-qwer-asdf-zxcv"

QubeSync.delete_connection("asdf-qwer-asdf-zxcv") # deletes the connection in QUBE
#=> true

QubeSync.get_connection("asdf-qwer-asdf-zxcv") # gets the connection in QUBE
#=> {"data"=>{"id"=>"07ba16ed-5282-4622-aa68-c6e0f8ff5f5a"}}

QubeSync.queue_request(connection_id, request_xml, webhook_url)

QubeSync.get_request(request_id)
#=> {"data"=>
#   {"id"=>"d401228f-06d4-4981-95d8-bb735c0a2c76",
#    "state"=>"webhook_succeeded",
#    "response_xml"=>
#     "<?xml version=\"1.0\" ?> <QBXML> <QBXMLMsgsRs> ... </QBXMLMsgsRs> </QBXML>",
#    "webhook_url"=>"myapp.com/webhook",
#    "request_xml"=>
#     "<?xml version=\"1.0\"?><?qbxml version=\"16.0\"?><QBXML>  ...  </QBXMLMsgsRq></QBXML>"}}

QubeSync.generate_password(connection_id)
#=> "password123"

QubeSync.get_qwc(connection_id)
# "<?xml version=\"1.0\"?>\n<QBWCXML>...</QBWCXML>\n"

QubeSync.verify_and_build_webhook!(request.body.read, request.headers['X-Qube-Signature'])
#=> {
#  "id"=>"dd8db40a-5169-477a-b9d5-f1a6e5cc96f9",
#  "timestamp"=>1738620998,
#  "response_xml"=>
#   "<?xml version=\"1.0\" ?> <QBXML> <QBXMLMsgsRs> ... </QBXMLMsgsRs> </QBXML>" 
# }

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qubeintegrations/qube_sync.
