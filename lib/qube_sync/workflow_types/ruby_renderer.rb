# frozen_string_literal: true

module QubeSync
  module WorkflowTypes
    # Writes the Ruby half of a render: QubeWorkflows, a module per workflow, its start and input
    # methods, documented with YARD. Plain Ruby that loads on 2.7 as well, since qube_rails writes
    # the same file into Rails apps: no endless methods, no `it`, no hash shorthand.
    class RubyRenderer
      RUBY_KEYWORDS = %w[
        alias and begin break case class def do else elsif end ensure false for if in module next nil not
        or redo rescue retry return self super then true undef unless until when while yield
      ].freeze
      # A start method's own parameters: an input named after one takes a trailing underscore in
      # its methods (`version_:`), and keeps its name in the input.
      RUN_PARAMS = %w[connection reference webhook_url version client].freeze

      # input: the Workflow::Input; name: its parameter's name; positional: taken positionally.
      Param = Struct.new(:input, :name, :positional, keyword_init: true)

      # The body first (positional), then the other inputs as keywords, sorted. A name that's a
      # start's own, or a Ruby keyword taken positionally, takes a trailing underscore. The RBS
      # names its parameters the same.
      def self.params_for(inputs, body)
        taken = inputs.map(&:name)
        ordered = body ? [body] + (inputs - [body]) : inputs
        ordered.map do |input|
          positional = input.equal?(body)
          name = input.name
          if RUN_PARAMS.include?(name) || (positional && RUBY_KEYWORDS.include?(name))
            name = "#{name}_"
            name = "#{name}_" while taken.include?(name)
            taken << name
          end
          Param.new(input: input, name: name, positional: positional)
        end
      end

      def initialize(workflows, header:, client:)
        @workflows = workflows
        @header = header
        @client = client
        @setter = client == DEFAULT_CLIENT
      end

      def render
        lines = @header + ["# frozen_string_literal: true", ""]
        lines.concat(top_doc)
        lines << "module QubeWorkflows"
        lines.concat(client_accessors) if @setter
        lines.concat(connection_id_method)
        @workflows.each do |workflow|
          lines << ""
          lines.concat(accessor(workflow))
        end
        @workflows.each do |workflow|
          lines << ""
          lines.concat(workflow_module(workflow))
        end
        lines.concat(["end", ""])
        lines.join("\n")
      end

      private

      def top_doc
        client = @client.delete_prefix("::")
        text = [
          "Your app's QuBe Sync workflows, from their input types: QubeWorkflows.<workflow> is a workflow's module, " \
            "with a start method per branch of its input (QubeWorkflows.<workflow>.<branch>(connection, body, ..., " \
            "reference:, webhook_url:)), or start(connection, <inputs>, reference:, webhook_url:) for a workflow " \
            "whose input has no branches. Each <branch>_input (or input) returns the input alone, as a Hash " \
            "without its nil values. connection is a connection's QuBe Sync id, or anything with a qube_id " \
            "(a QubeRails::Connection).",
          if @setter
            "A start uses QubeWorkflows.client unless it's passed another as client:. Set it once, at boot: " \
              "QubeWorkflows.client = QubeSync::Client.new(api_key: ENV.fetch(\"QUBE_API_KEY\"))."
          else
            "A start uses #{client} unless it's passed another as client:."
          end,
          "The signatures are in sig/qube_workflows.rbs. An operation's body is typed as that operation's " \
            "params, its required fields included, but a workflow may fill some in itself (customer_ref, " \
            "list_id, edit_sequence): QuBe Sync checks an input's fields and types when the run starts, and " \
            "required fields when it sends the request."
        ]
        text.flat_map { |paragraph| ["#"] + WorkflowTypes.wrap(paragraph, "# ", "# ") }.drop(1)
      end

      def client_accessors
        [
          "  class << self",
          "    attr_writer :client",
          "",
          "    # The QubeSync::Client a start uses unless given client:.",
          "    def client",
          "      @client || raise(::ArgumentError, \"QubeWorkflows.client isn't set: set it once, at boot \" \\",
          "        \"(QubeWorkflows.client = QubeSync::Client.new(api_key: ...)), or pass client:\")",
          "    end",
          "  end",
          ""
        ]
      end

      def connection_id_method
        [
          "  # A connection's QuBe Sync id: connection itself, or its qube_id when it has one (a",
          "  # QubeRails::Connection).",
          "  def self.connection_id(connection)",
          "    connection.respond_to?(:qube_id) ? connection.qube_id : connection",
          "  end"
        ]
      end

      def accessor(workflow)
        [
          "  # #{title(workflow)} (`#{workflow.key}`): QubeWorkflows::#{workflow.const}.",
          "  def self.#{workflow.accessor}",
          "    #{workflow.const}",
          "  end"
        ]
      end

      def title(workflow)
        workflow.name.strip.empty? ? workflow.key : workflow.name.split.join(" ")
      end

      def workflow_module(workflow)
        version = workflow.draft ? "a draft, not published yet" : "version #{workflow.version.inspect}"
        intro = "#{title(workflow)} (`#{workflow.key}`, #{version})."
        intro = "#{intro} #{workflow.description}" unless workflow.description.strip.empty?
        lines = WorkflowTypes.wrap(intro, "  # ", "  # ")
        if workflow.discriminated?
          names = workflow.branches.map { |branch| "#{branch.method} (#{branch.value.inspect})" }
          lines << "  #"
          lines.concat(WorkflowTypes.wrap("A start method per `#{workflow.discriminator}`: #{names.join(", ")}. " \
            "start takes any of their inputs.", "  # ", "  # "))
        end
        lines << "  module #{workflow.const}"
        lines << "    WORKFLOW = #{workflow.key.inspect}"
        lines << "    # The version these types describe (nil for a draft). A start runs the published version"
        lines << "    # unless given version:."
        lines << "    VERSION = #{workflow.version.inspect}"
        if workflow.discriminated?
          workflow.branches.each do |branch|
            lines << ""
            lines.concat(branch_method(workflow, branch))
            lines << ""
            lines.concat(branch_input_method(workflow, branch))
          end
          lines << ""
          lines.concat(start_any_method(workflow))
        else
          lines << ""
          lines.concat(start_method(workflow))
          lines << ""
          lines.concat(input_method(workflow))
        end
        lines << "  end"
        lines
      end

      # -- Methods ----------------------------------------------------------------------------

      def branch_method(workflow, branch)
        params = params_for(branch.inputs, branch.body)
        doc = ["Starts #{workflow.key} with `#{workflow.discriminator}` #{branch.value.inspect}."]
        lines = doc_lines(doc, [connection_tag] + input_tags(params) + run_tags + return_tags + see_tags(branch.inputs))
        call = call_args(params)
        lines << "    def self.#{branch.method}(#{(["connection"] + signature(params) + run_signature).join(", ")})"
        lines << "      start(connection, #{branch.method}_input(#{call}), reference: reference, webhook_url: webhook_url, " \
          "version: version, client: client)"
        lines << "    end"
      end

      def branch_input_method(workflow, branch)
        params = params_for(branch.inputs, branch.body)
        doc = ["#{workflow.key}'s input with `#{workflow.discriminator}` #{branch.value.inspect}, without its nil " \
          "values: for start, or a QubeRails::Operation's input."]
        lines = doc_lines(doc, input_tags(params) + ["@return [Hash] the input"] + see_tags(branch.inputs))
        pairs = ["#{label(workflow.discriminator)} #{branch.value.inspect}"] + pairs(params)
        lines << "    def self.#{branch.method}_input(#{signature(params).join(", ")})"
        lines << "      {#{pairs.join(", ")}}.compact"
        lines << "    end"
      end

      def start_any_method(workflow)
        inputs = workflow.branches.map { |branch| "#{branch.method}_input" }
        doc = ["Starts #{workflow.key} with any of its inputs: a Hash as #{inputs.join(" or ")} returns it."]
        tags = [connection_tag, "@param input [Hash] the input"] + run_tags + return_tags
        lines = doc_lines(doc, tags)
        lines << "    def self.start(#{(["connection", "input"] + run_signature).join(", ")})"
        lines << "      client.start_run(::QubeWorkflows.connection_id(connection), WORKFLOW, input, reference: reference, " \
          "webhook_url: webhook_url, version: version)"
        lines << "    end"
      end

      def start_method(workflow)
        params = params_for(workflow.inputs, nil)
        doc = ["Starts #{workflow.key}."]
        lines = doc_lines(doc, [connection_tag] + input_tags(params) + run_tags + return_tags + see_tags(workflow.inputs))
        lines << "    def self.start(#{(["connection"] + signature(params) + run_signature).join(", ")})"
        lines << "      client.start_run(::QubeWorkflows.connection_id(connection), WORKFLOW, input(#{call_args(params)}), " \
          "reference: reference, webhook_url: webhook_url, version: version)"
        lines << "    end"
      end

      def input_method(workflow)
        params = params_for(workflow.inputs, nil)
        doc = ["#{workflow.key}'s input, without its nil values: for start, or a QubeRails::Operation's input."]
        lines = doc_lines(doc, input_tags(params) + ["@return [Hash] the input"] + see_tags(workflow.inputs))
        lines << "    def self.input(#{signature(params).join(", ")})"
        lines << "      {#{pairs(params).join(", ")}}.compact"
        lines << "    end"
      end

      # -- Parameters -------------------------------------------------------------------------

      def params_for(inputs, body)
        self.class.params_for(inputs, body)
      end

      def signature(params)
        params.map do |param|
          if param.positional
            param.name
          elsif param.input.required
            "#{param.name}:"
          else
            "#{param.name}: nil"
          end
        end
      end

      def run_signature
        ["reference:", "webhook_url:", "version: nil", "client: #{@client}"]
      end

      # A parameter's value: a keyword that's also a Ruby keyword (`class:`) is read through the
      # binding.
      def value(param)
        (!param.positional && RUBY_KEYWORDS.include?(param.name)) ? "binding.local_variable_get(:#{param.name})" : param.name
      end

      def call_args(params)
        params.map { |param| param.positional ? value(param) : "#{param.name}: #{value(param)}" }.join(", ")
      end

      def pairs(params)
        params.map { |param| "#{label(param.input.name)} #{value(param)}" }
      end

      def label(name)
        "#{name}:"
      end

      # -- YARD -------------------------------------------------------------------------------

      def doc_lines(paragraphs, tags)
        lines = paragraphs.flat_map { |text| WorkflowTypes.wrap(text, "    # ", "    # ") }
        lines << "    #"
        tags.each { |tag| lines.concat(WorkflowTypes.wrap(tag, "    # ", "    #   ")) }
        lines
      end

      def connection_tag
        "@param connection [String, #qube_id] the connection's QuBe Sync id, or a QubeRails::Connection"
      end

      def run_tags
        [
          "@param reference [String] your reference for the run, also its Idempotency-Key, so a retry never starts a second run",
          "@param webhook_url [String] where QuBe Sync sends the run's webhooks",
          "@param version [Integer, nil] the version to run; nil runs the published one",
          "@param client [QubeSync::Client] defaults to #{@client.delete_prefix("::")}"
        ]
      end

      def return_tags
        ["@return [Hash] the run, as QubeSync::Client#start_run returns it"]
      end

      def input_tags(params)
        params.map do |param|
          types = yard_types(param.input.schema)
          types << "nil" unless param.input.required || types.include?("nil")
          text = input_text(param.input.schema)
          text = "the `#{param.input.name}` input. #{text}" unless param.name == param.input.name
          "@param #{param.name} [#{types.join(", ")}] #{text}".rstrip
        end
      end

      def see_tags(inputs)
        inputs.filter_map { |input| (id = Workflow.operation(input.schema)) && Workflow.known_operation(id) }
          .uniq.sort.map { |entity, action| "@see QubeSync::Operations::#{entity}##{action}" }
      end

      def input_text(schema)
        parts = []
        id = Workflow.operation(schema)
        parts << operation_phrase(id) if id
        description = schema["description"].to_s.strip
        parts[-1] = "#{parts[-1]}:" if id && !description.empty?
        parts << description unless description.empty?
        parts << "One of #{schema["enum"].map(&:inspect).join(", ")}." if schema["enum"].is_a?(Array)
        parts << "Always #{schema["const"].inspect}." if schema.key?("const")
        extra = schema["additionalProperties"]
        if extra.is_a?(Hash) && extra["enum"].is_a?(Array)
          parts << "Each value is one of #{extra["enum"].map(&:inspect).join(", ")}."
        end
        nested = schema["items"].is_a?(Hash) ? schema["items"] : schema
        parts << branches_phrase(nested, nested.equal?(schema) ? "It's" : "Each is") if !id && Workflow.discriminated?(nested)
        parts.join(" ")
      end

      def operation_phrase(id)
        known = Workflow.known_operation(id)
        if known
          "the #{id} body (see QubeSync::Operations::#{known[0]}##{known[1]})"
        else
          "the #{id} body (an operation this version of qube_sync doesn't know)"
        end
      end

      # A nested discriminated object's branches: `"customer", whose add is the customer.create
      # body (...)`.
      def branches_phrase(schema, subject)
        discriminator = schema.dig("discriminator", "propertyName")
        branches = Workflow.branch_schemas(schema).map do |_title, properties, _required|
          fixed = properties[discriminator] || {}
          value = fixed.key?("const") ? fixed["const"] : Array(fixed["enum"]).first
          bodies = properties.sort.filter_map do |name, sub|
            id = Workflow.operation(sub)
            "`#{name}` is #{operation_phrase(id)}" if id
          end
          bodies.empty? ? value.inspect : "#{value.inspect}, whose #{bodies.join(" and ")}"
        end
        "#{subject} one of these, by `#{discriminator}`: #{branches.join("; ")}."
      end

      def yard_types(schema)
        return ["Hash"] if Workflow.operation(schema)

        types = Array(schema["type"])
        if types.empty?
          return [literal_type(schema["const"])] if schema.key?("const")
          return schema["enum"].map { |value| literal_type(value) }.uniq if schema["enum"].is_a?(Array)
          return ["Hash"] if schema.key?("properties") || schema.key?("oneOf")
          return ["Array<#{yard_types(schema["items"] || {}).join(", ")}>"] if schema.key?("items")

          return ["Object"]
        end
        types.map do |type|
          case type
          when "string" then "String"
          when "integer" then "Integer"
          when "number" then "Numeric"
          when "boolean" then "Boolean"
          when "null" then "nil"
          when "array" then "Array<#{yard_types(schema["items"] || {}).join(", ")}>"
          when "object" then hash_type(schema)
          else "Object"
          end
        end.uniq
      end

      def hash_type(schema)
        extra = schema["additionalProperties"]
        if extra.is_a?(Hash) && !schema.key?("properties")
          "Hash{String => #{yard_types(extra).join(", ")}}"
        else
          "Hash"
        end
      end

      def literal_type(value)
        case value
        when String then "String"
        when Integer then "Integer"
        when Float then "Float"
        when true, false then "Boolean"
        when nil then "nil"
        else "Object"
        end
      end
    end
  end
end
