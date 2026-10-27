# frozen_string_literal: true

require "fileutils"
require "optparse"

module QubeSync
  module WorkflowTypes
    # `qube_sync workflows [--drafts] [--check] [--output lib/qube_workflows.rb] [--sig sig/qube_workflows.rbs]`
    #
    # Fetches the app's workflow types with QUBE_API_KEY (from QUBE_BASE_URL, default
    # https://qubesync.com) and writes the typed Ruby file and its RBS. With --check it writes
    # nothing: it exits 1 when the file is out of date (or QuBe Sync refuses the key), and 0 when
    # it's current or QuBe Sync can't be reached, with a warning, so CI isn't held up by an
    # outage. Returns the exit status.
    class CLI
      USAGE = "Usage: qube_sync workflows [--drafts] [--check] [--output PATH] [--sig PATH]"

      # env, out and err are for tests; client_factory takes (api_key:, base_url:).
      def initialize(env: ENV, out: $stdout, err: $stderr, client_factory: nil)
        @env = env
        @out = out
        @err = err
        @client_factory = client_factory || ->(api_key:, base_url:) { Client.new(api_key: api_key, base_url: base_url) }
      end

      def run(argv)
        command, *rest = argv
        unless command == "workflows"
          @err.puts USAGE
          return %w[-h --help help].include?(command) ? 0 : 1
        end

        options = {drafts: false, check: false, output: "lib/qube_workflows.rb", sig: "sig/qube_workflows.rbs"}
        parser = OptionParser.new do |opts|
          opts.banner = USAGE
          opts.on("--drafts", "Type each workflow's draft where it has one") { options[:drafts] = true }
          opts.on("--check", "Write nothing; exit 1 when the files are out of date") { options[:check] = true }
          opts.on("--output PATH", "The Ruby file (lib/qube_workflows.rb)") { |path| options[:output] = path }
          opts.on("--sig PATH", "The RBS file (sig/qube_workflows.rbs)") { |path| options[:sig] = path }
        end
        begin
          parser.parse!(rest)
        rescue OptionParser::ParseError => e
          @err.puts "qube_sync: #{e.message}"
          @err.puts parser.help
          return 1
        end
        unless rest.empty?
          @err.puts parser.help
          return 1
        end

        api_key = @env["QUBE_API_KEY"].to_s
        if api_key.strip.empty?
          @err.puts "qube_sync: set QUBE_API_KEY to your app's API key"
          return 1
        end

        base_url = @env["QUBE_BASE_URL"].to_s.strip
        base_url = Client::DEFAULT_BASE_URL if base_url.empty?
        # The site, or its API: QUBE_BASE_URL may name either.
        base_url = base_url.sub(%r{/+\z}, "").delete_suffix(Client::API_PATH)
        client = @client_factory.call(api_key: api_key, base_url: base_url)
        source = "#{client.base_url}#{Client::API_PATH}/workflows/types"

        options[:check] ? check(client, source, options) : generate(client, source, options)
      rescue Error, ArgumentError => e
        @err.puts "qube_sync: #{e.message}"
        1
      end

      private

      def generate(client, source, options)
        document = client.workflow_types(include_drafts: options[:drafts])
        files = WorkflowTypes.render(document, source: source, drafts: options[:drafts])
        files.warnings.each { |warning| @err.puts "warning: #{warning}" }
        write(options[:output], files.ruby)
        write(options[:sig], files.rbs)
        count = WorkflowTypes.select(document, options[:drafts]).size
        @out.puts "qube_sync: #{count} workflow#{"s" unless count == 1} from #{source}#{" (with drafts)" if options[:drafts]}"
        0
      rescue APIError => e
        @err.puts "qube_sync: #{e.message}"
        1
      rescue *Client::NETWORK_ERRORS, SystemCallError => e
        @err.puts "qube_sync: couldn't reach QuBe Sync (#{e.class}: #{e.message}); nothing was written"
        1
      end

      def check(client, source, options)
        path = options[:output]
        unless File.exist?(path)
          @err.puts "qube_sync: #{path} isn't there: run `#{COMMAND}` to write it"
          return 1
        end

        result = WorkflowTypes.check(File.read(path, encoding: "UTF-8"), client: client, source: source, path: path)
        result.warnings.each { |warning| @err.puts "warning: #{warning}" }
        case result.status
        when :current then @out.puts "qube_sync: #{result.message}"
        when :unreachable then @err.puts "warning: #{result.message}"
        else @err.puts "qube_sync: #{result.message}"
        end
        result.exit_status
      end

      def write(path, content)
        dir = File.dirname(path)
        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
        if File.exist?(path) && File.read(path, encoding: "UTF-8") == content
          @out.puts "identical #{path}"
        else
          File.write(path, content)
          @out.puts "wrote #{path}"
        end
      end
    end
  end
end
