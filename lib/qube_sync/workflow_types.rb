# frozen_string_literal: true

require "json"
require_relative "client"
require_relative "workflow_types/workflow"
require_relative "workflow_types/ruby_renderer"
require_relative "workflow_types/rbs_renderer"
require_relative "workflow_types/cli"

module QubeSync
  # Turns an app's workflow input types (Client#workflow_types, GET /api/v2/workflows/types) into
  # a typed Ruby file and its RBS: a QubeWorkflows module with one module per workflow, and a
  # start method per branch of a workflow's input, whose operation bodies are typed as the
  # operation's own params (QubeSync::Operations::<Entity>::<action>_params).
  #
  #   files = QubeSync::WorkflowTypes.render(client.workflow_types, source: "https://qubesync.com/api/v2/workflows/types")
  #   File.write("lib/qube_workflows.rb", files.ruby)
  #   File.write("sig/qube_workflows.rbs", files.rbs)
  #
  # `qube_sync workflows` (exe/qube_sync, WorkflowTypes::CLI) does this, and `--check` compares a
  # written file with what QuBe Sync serves; qube_rails' `bin/rails g qube_rails:workflows` does
  # the same in a Rails app. The same document gives byte-identical files.
  module WorkflowTypes
    # A document this version can't render: not a workflow types document, or a name that isn't
    # one QuBe Sync allows.
    class Error < QubeSync::Error; end

    COMMAND = "qube_sync workflows"
    WIDTH = 100
    # What a start method's client defaults to when none is given: set once, at boot.
    DEFAULT_CLIENT = "::QubeWorkflows.client"

    # The rendered files; digest and drafts are what their header records.
    Files = Struct.new(:ruby, :rbs, :digest, :drafts, :warnings, keyword_init: true)

    # What a generated file's header records: the document's digest, and whether it was made
    # with drafts.
    Header = Struct.new(:digest, :drafts, keyword_init: true)

    # What a --check found. status is :current, :stale (changes lists the workflows, as
    # "add_transaction (changed)", "resolve (new)", "upsert (removed)"), :unreachable (QuBe Sync
    # didn't answer, or answered 5xx: nothing was checked) or :error (a 401, another 4xx, a file
    # without a header). message is one line.
    Check = Struct.new(:status, :message, :changes, :warnings, keyword_init: true) do
      # 0 when the file is current, and when QuBe Sync couldn't be reached (CI warns, and the
      # file keeps working); 1 otherwise.
      def exit_status
        (status == :current || status == :unreachable) ? 0 : 1
      end
    end

    module_function

    # Renders a document's workflows: each published one at its published version, or with
    # `drafts: true` each workflow's draft where it has one. `source` is the URL the header
    # names, `command` the command it says to run again, and `client` the Ruby expression a
    # start method's client defaults to (DEFAULT_CLIENT, with a QubeWorkflows.client= setter; any
    # other has none).
    def render(document, source:, drafts: false, command: COMMAND, client: DEFAULT_CLIENT)
      document = validate(document)
      workflows = select(document, drafts).map { |key, entry| Workflow.new(key, entry) }
      consts = workflows.group_by(&:const).select { |_const, same| same.size > 1 }
      unless consts.empty?
        raise Error, "workflows #{consts.values.flatten.map(&:key).join(", ")} would share a module name"
      end

      header = header_lines(source, drafts ? "#{command} --drafts" : command, document["digest"], drafts)
      Files.new(
        ruby: RubyRenderer.new(workflows, header: header, client: client).render,
        rbs: RBSRenderer.new(workflows, header: header, client: client).render,
        digest: document["digest"],
        drafts: drafts,
        warnings: warnings(document)
      )
    end

    # The workflows a render types, by key, sorted: the published ones, each replaced by its
    # draft when drafts is true, and the drafts of workflows never published.
    def select(document, drafts)
      chosen = (document["workflows"] || {}).dup
      (document["drafts"] || {}).each { |key, entry| chosen[key] = entry } if drafts
      chosen.sort.to_h
    end

    # The digest and drafts a generated file's header records, or nil when it has none.
    def header(source)
      lines = source.to_s.each_line.first(10)
      digest = lines.filter_map { |line| line[/\A# digest: (\S+)\s*\z/, 1] }.first
      drafts = lines.filter_map { |line| line[/\A# drafts: (true|false)\s*\z/, 1] }.first
      return nil unless digest && drafts

      Header.new(digest: digest, drafts: drafts == "true")
    end

    # The workflows whose generated module differs between two renders, by key, sorted.
    def changes(before, after)
      old = workflow_blocks(before)
      new = workflow_blocks(after)
      (old.keys | new.keys).sort.filter_map do |key|
        if !old.key?(key)
          "#{key} (new)"
        elsif !new.key?(key)
          "#{key} (removed)"
        elsif old[key] != new[key]
          "#{key} (changed)"
        end
      end
    end

    # Compares a generated file (its Ruby source) with what QuBe Sync serves now, fetched with the
    # drafts flag the file records. client is a QubeSync::Client, or anything answering
    # workflow_types as it does; path names the file in messages. Takes render's options, so the
    # changes it lists are the ones running `command` again would make.
    def check(existing, client:, source:, path:, command: COMMAND, client_expression: DEFAULT_CLIENT)
      recorded = header(existing)
      unless recorded
        return Check.new(status: :error, changes: [], warnings: [],
          message: "#{path} has no digest header: run `#{command}` to write it")
      end

      again = recorded.drafts ? "#{command} --drafts" : command
      document =
        begin
          client.workflow_types(include_drafts: recorded.drafts, etag: recorded.digest)
        rescue APIError => e
          return unreachable("QuBe Sync answered #{e.status}") if e.status >= 500

          return Check.new(status: :error, changes: [], warnings: [], message: e.message)
        rescue *Client::NETWORK_ERRORS, SystemCallError => e
          return unreachable("#{e.class}: #{e.message}")
        end
      return current(path, []) if document == :not_modified

      files = render(document, source: source, drafts: recorded.drafts, command: command, client: client_expression)
      return current(path, files.warnings) if files.digest == recorded.digest

      changed = changes(existing, files.ruby)
      what = changed.empty? ? "the served types changed" : changed.join(", ")
      Check.new(status: :stale, changes: changed, warnings: files.warnings,
        message: "#{path} is out of date (#{what}): run `#{again}` and commit the result")
    end

    def current(path, warnings)
      Check.new(status: :current, changes: [], warnings: warnings, message: "#{path} is up to date")
    end

    def unreachable(why)
      Check.new(status: :unreachable, changes: [], warnings: [],
        message: "couldn't reach QuBe Sync (#{why}), so the workflow types weren't checked")
    end

    # A served operations_digest other than this gem's: the document's $operation ids may name
    # operations this version doesn't type.
    def warnings(document)
      served = document["operations_digest"]
      return [] if served.nil? || served == Operations::DIGEST

      ["QuBe Sync's operations (#{served}) aren't the ones qube_sync #{VERSION} was generated from " \
        "(#{Operations::DIGEST}): an operation it doesn't know is typed as a plain Hash. Update qube_sync to type it."]
    end

    def validate(document)
      unless document.is_a?(Hash) && document["digest"].is_a?(String) && document["workflows"].is_a?(Hash)
        raise Error, "not a workflow types document (expected digest and workflows)"
      end
      unless document["digest"].match?(/\A[\w:.\-]+\z/)
        raise Error, "not a workflow types document: digest #{document["digest"].inspect}"
      end

      document
    end

    # Word-wraps text to WIDTH, as bin/generate-operations does: the first line starts with
    # `first`, the others with `rest`. Splitting on whitespace keeps a newline in a description
    # from ending a comment.
    def wrap(text, first, rest)
      lines = []
      line = first.dup
      fresh = true
      text.to_s.split.each do |word|
        if !fresh && line.length + 1 + word.length > WIDTH
          lines << line
          line = rest + word
        else
          line << (fresh ? "" : " ") << word
        end
        fresh = false
      end
      lines << line
      lines.map(&:rstrip)
    end

    def header_lines(source, command, digest, drafts)
      [
        "# Generated by `#{command}` from #{source}: don't edit.",
        "# Run it again when a workflow changes; `#{command} --check` fails while this file is out of date.",
        "# digest: #{digest}",
        "# drafts: #{drafts}"
      ]
    end

    # Each workflow's module in a generated Ruby file, with its comment, by its WORKFLOW key.
    def workflow_blocks(source)
      lines = source.to_s.lines
      blocks = {}
      lines.each_with_index do |line, i|
        next unless line.match?(/\A  module [A-Z]\w*$/)

        first = i
        first -= 1 while first.positive? && lines[first - 1].start_with?("  #")
        last = (i...lines.size).find { |j| lines[j] == "  end\n" } || (lines.size - 1)
        block = lines[first..last].join
        key = block[/^    WORKFLOW = "([^"]+)"$/, 1]
        blocks[key] = block if key
      end
      blocks
    end
  end
end
