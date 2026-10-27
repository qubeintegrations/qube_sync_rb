# frozen_string_literal: true

require "json"

module QubeSync
  module WorkflowTypes
    # Writes the RBS half of a render: a type alias per input (`invoice_input`, or `input` for a
    # workflow without branches), each operation body as that operation's params record
    # (::QubeSync::Operations::Invoice::create_params), a nested discriminated object (an `adds`
    # entry) as a union of a record per branch, and the start and input methods' signatures. JSON
    # Schema maps to RBS as bin/generate-operations maps it.
    class RBSRenderer
      # Words RBS doesn't take as a type alias's name: one gets a trailing underscore.
      RBS_KEYWORDS = %w[
        alias as attr_accessor attr_reader attr_writer bool bot class def end extend false in include instance
        interface module nil out prepend private public self singleton super top true type unchecked untyped
        use void
      ].freeze
      # A string RBS can take as a literal type as it is.
      PLAIN_STRING = %r{\A[\w .:/@+\-]*\z}
      DATA = "::QubeSync::Client::data"

      def initialize(workflows, header:, client:)
        @workflows = workflows
        @header = header
        @setter = client == DEFAULT_CLIENT
      end

      def render
        lines = @header + ["", "module QubeWorkflows"]
        lines << "  # Anything with a QuBe Sync connection id, such as a QubeRails::Connection."
        lines << "  interface _Connection"
        lines << "    def qube_id: () -> String?"
        lines << "  end"
        lines << ""
        lines << "  type connection = String | _Connection"
        lines << ""
        if @setter
          lines << "  def self.client: () -> ::QubeSync::Client"
          lines << "  def self.client=: (::QubeSync::Client client) -> ::QubeSync::Client"
        end
        lines << "  def self.connection_id: (connection connection) -> String?"
        @workflows.each do |workflow|
          lines << "  def self.#{workflow.accessor}: () -> singleton(#{workflow.const})"
        end
        @workflows.each do |workflow|
          lines << ""
          lines.concat(workflow_rbs(workflow))
        end
        lines.concat(["end", ""])
        lines.join("\n")
      end

      private

      def workflow_rbs(workflow)
        @aliases = {}
        @memo = {}
        @prefix = nil
        @taken = ["input"] + workflow.branches.map { |branch| "#{branch.method}_input" }
        inputs = {}
        methods = []
        if workflow.discriminated?
          workflow.branches.each do |branch|
            # A body's own record is named for its branch.
            @prefix = branch.method
            fields = [[workflow.discriminator, literal(branch.value), true]] +
              branch.inputs.map { |input| [input.name, type(input.schema, input.name, "      "), input.required] }
            inputs["#{branch.method}_input"] = record(fields, "    ")
            params = RubyRenderer.params_for(branch.inputs, branch.body)
            methods << "    def self.#{branch.method}: (#{(connection + signature(params) + run).join(", ")}) -> #{DATA}"
            methods << "    def self.#{branch.method}_input: (#{signature(params).join(", ")}) -> #{branch.method}_input"
          end
          @prefix = nil
          inputs["input"] = workflow.branches.map { |branch| "#{branch.method}_input" }.join(" | ")
          methods << "    def self.start: (#{(connection + ["input input"] + run).join(", ")}) -> #{DATA}"
        else
          fields = workflow.inputs.map { |input| [input.name, type(input.schema, input.name, "      "), input.required] }
          inputs["input"] = record(fields, "    ")
          params = RubyRenderer.params_for(workflow.inputs, nil)
          methods << "    def self.start: (#{(connection + signature(params) + run).join(", ")}) -> #{DATA}"
          methods << "    def self.input: (#{signature(params).join(", ")}) -> input"
        end

        lines = ["  module #{workflow.const}", "    WORKFLOW: String", "    VERSION: #{workflow.version.nil? ? "nil" : "Integer"}", ""]
        @aliases.sort.each do |name, rbs|
          lines << "    type #{name} = #{rbs}"
          lines << ""
        end
        inputs.each do |name, rbs|
          lines << "    type #{name} = #{rbs}"
          lines << ""
        end
        lines.concat(methods)
        lines << "  end"
      end

      def connection
        ["::QubeWorkflows::connection connection"]
      end

      def run
        ["reference: String", "webhook_url: String", "?version: Integer?", "?client: ::QubeSync::Client"]
      end

      # A method's inputs, named as the Ruby names them: required ones as `name: T`, the others as
      # `?name: T?` (a nil is left out of the input).
      def signature(params)
        params.map do |param|
          rbs = type(param.input.schema, param.input.name, nil)
          if param.positional
            RBS_KEYWORDS.include?(param.name) ? rbs : "#{rbs} #{param.name}"
          elsif param.input.required
            "#{param.name}: #{rbs}"
          else
            "?#{param.name}: #{optional(rbs)}"
          end
        end
      end

      # -- Types ------------------------------------------------------------------------------

      def type(schema, path, indent)
        union(members(schema, path, indent))
      end

      def members(schema, path, indent)
        id = Workflow.operation(schema)
        return [body_type(id, schema, path)] if id
        return [named(schema, path)] if Workflow.discriminated?(schema)
        return [literal(schema["const"])] if schema.key?("const")
        return schema["enum"].map { |value| literal(value) } if schema["enum"].is_a?(Array)

        types = Array(schema["type"])
        if types.empty?
          types << "object" if schema.key?("properties")
          types << "array" if schema.key?("items")
        end
        return ["untyped"] if types.empty?

        types.map do |kind|
          case kind
          when "string" then "String"
          when "integer" then "Integer"
          when "number" then "Numeric"
          when "boolean" then "bool"
          when "null" then "nil"
          when "array" then "Array[#{type(schema["items"].is_a?(Hash) ? schema["items"] : {}, "#{path}_item", indent)}]"
          when "object" then object_type(schema, path, indent)
          else "untyped"
          end
        end
      end

      def union(members)
        members = members.uniq
        return "untyped" if members.include?("untyped")

        others = members - ["nil"]
        return members.join(" | ") if others.size == members.size
        return "nil" if others.empty?

        optional(others.join(" | "))
      end

      def optional(rbs)
        return rbs if rbs == "untyped" || rbs == "nil" || rbs.end_with?("?")

        top_level_union?(rbs) ? "(#{rbs})?" : "#{rbs}?"
      end

      # A `|` outside any brackets: `"a" | "b"`, not `Hash[String, "a" | "b"]`.
      def top_level_union?(rbs)
        depth = 0
        rbs.each_char.each_cons(3) do |before, char, after|
          depth += 1 if "[{(".include?(before)
          depth -= 1 if "]})".include?(before)
          return true if depth.zero? && char == "|" && before == " " && after == " "
        end
        false
      end

      def object_type(schema, path, indent)
        properties = schema["properties"].is_a?(Hash) ? schema["properties"] : {}
        extra = schema["additionalProperties"]
        if properties.empty?
          return "Hash[String, #{type(extra, "#{path}_value", indent)}]" if extra.is_a?(Hash)

          return "Hash[untyped, untyped]"
        end
        # A field name a record can't hold types the object as a plain Hash.
        return "Hash[untyped, untyped]" unless properties.keys.all? { |name| name.match?(Workflow::NAME) }

        required = Array(schema["required"])
        fields = properties.sort.map do |name, sub|
          [name, type(sub.is_a?(Hash) ? sub : {}, "#{path}_#{name}", indent && "#{indent}  "), required.include?(name)]
        end
        record(fields, indent)
      end

      # A record over lines at indent, or on one line when indent is nil (in a signature).
      def record(fields, indent)
        return "Hash[Symbol, untyped]" if fields.empty?
        return "{ #{fields.map { |name, rbs, required| "#{required ? "" : "?"}#{name}: #{rbs}" }.join(", ")} }" if indent.nil?

        lines = fields.map { |name, rbs, required| "#{indent}  #{required ? "" : "?"}#{name}: #{rbs}" }
        "{\n#{lines.join(",\n")}\n#{indent}}"
      end

      # A nested discriminated object's alias: a union of a record per branch, each named
      # <alias>_<title>. The same schema at the same place shares one.
      def named(schema, path)
        key = [path, JSON.generate(schema)]
        return @memo[key] if @memo.key?(key)

        name = claim(path)
        @memo[key] = name
        # Shared by every branch of the workflow, so not named for one.
        prefix = @prefix
        @prefix = nil
        discriminator = schema.dig("discriminator", "propertyName")
        branches = Workflow.branch_schemas(schema).map do |title, properties, required|
          branch = claim("#{name}_#{title}")
          fields = properties.sort_by { |field, _| [field == discriminator ? 0 : 1, field] }.map do |field, sub|
            sub = sub.is_a?(Hash) ? sub : {}
            [field, type(sub, "#{name}_#{field}", "      "), field == discriminator || required.include?(field)]
          end
          if fields.any? { |field, _, _| !field.match?(Workflow::NAME) }
            @aliases[branch] = "Hash[untyped, untyped]"
          else
            @aliases[branch] = record(fields, "    ")
          end
          branch
        end
        @aliases[name] = branches.empty? ? "Hash[untyped, untyped]" : branches.join(" | ")
        @prefix = prefix
        name
      end

      def claim(path)
        base = RBS_KEYWORDS.include?(path) ? "#{path}_" : path
        name = base
        n = 2
        while @taken.include?(name)
          name = "#{base}_#{n}"
          n += 1
        end
        @taken << name
        name
      end

      # An operation body: the operation's params alias, or, when the workflow sets some of its
      # required fields itself (set_by_workflow), a record of its own with those made optional,
      # named <branch>_<input>_body (<input>_body without branches). A field or an operation this
      # gem doesn't know is ignored.
      def body_type(id, schema, path)
        fields = Workflow.operation_fields(id)
        return operation_type(id) unless fields

        relaxed = Workflow.set_by_workflow(schema).select { |field| fields.key?(field) && fields[field][1] }
        return operation_type(id) if relaxed.empty?

        base = [@prefix, path].compact.join("_")
        key = [:body, base, id, relaxed]
        return @memo[key] if @memo.key?(key)

        name = claim("#{base}_body")
        @memo[key] = name
        @aliases[name] = record(fields.sort.map { |field, (rbs, required)| [field, rbs, required && !relaxed.include?(field)] }, "    ")
        name
      end

      def operation_type(id)
        known = Workflow.known_operation(id)
        known ? "::QubeSync::Operations::#{known[0]}::#{known[1]}_params" : "Hash[untyped, untyped]"
      end

      def literal(value)
        case value
        when String then value.match?(PLAIN_STRING) ? JSON.generate(value) : "String"
        when Integer then value.to_s
        when Float then "Float"
        when true, false then value.to_s
        when nil then "nil"
        else "untyped"
        end
      end
    end
  end
end
