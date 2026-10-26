# frozen_string_literal: true

module QubeSync
  module WorkflowTypes
    # One workflow of a types document, as the renderers read it: its names, its inputs and,
    # when its input is discriminated (an object with oneOf and a discriminator at the top),
    # its branches, each with the discriminator fixed.
    class Workflow
      # Workflow keys, input names and branch titles, as QuBe Sync allows them.
      NAME = /\A[a-z][a-z0-9_]{0,63}\z/
      OPERATION = /\A[a-z][a-z0-9_]*\.[a-z][a-z0-9_]*\z/

      # Public methods every module has: a workflow or branch named after one gets a trailing
      # underscore, as QuickBooks' class entity is client.class_. With the ones the generated
      # code calls on its own modules (raise, binding) and the ones it defines.
      MODULE_METHODS = %w[
        alias_method ancestors attr attr_accessor attr_reader attr_writer autoload class class_eval class_exec
        class_variable_get class_variable_set class_variables clone const_get const_missing const_set
        const_source_location constants define_method define_singleton_method deprecate_constant display dup
        enum_for extend freeze hash include included_modules inspect instance_eval instance_exec instance_method
        instance_methods instance_variable_get instance_variable_set instance_variables itself method methods
        module_eval module_exec name object_id prepend private_class_method private_constant
        private_instance_methods private_methods protected_instance_methods protected_methods public_class_method
        public_constant public_instance_method public_instance_methods public_method public_methods public_send
        refinements remove_class_variable remove_instance_variable remove_method send set_temporary_name
        singleton_class singleton_method singleton_methods tap then to_enum to_s undef_method
        undefined_instance_methods yield_self
        binding raise client client= connection_id
      ].freeze

      # name: the input's name; schema: its JSON Schema; required: whether the input must be given.
      Input = Struct.new(:name, :schema, :required, keyword_init: true)

      # title: the branch's name in the document; method: its start method's name; value: the
      # discriminator's const; inputs: the others, sorted by name; body: the workflow's one
      # operation-body input (a $operation in at least one branch), which every branch's methods
      # take positionally, or nil when the workflow has none or several.
      Branch = Struct.new(:title, :method, :value, :inputs, :body, keyword_init: true)

      attr_reader :key, :const, :accessor, :name, :description, :version, :draft, :schema, :discriminator,
        :inputs, :branches

      def initialize(key, entry)
        @key = checked_name(key, "workflow key")
        @const = key.split("_").map(&:capitalize).join
        @accessor = MODULE_METHODS.include?(key) ? "#{key}_" : key
        @name = entry["name"].to_s
        @description = entry["description"].to_s
        @version = entry["version"].is_a?(Integer) ? entry["version"] : nil
        @draft = entry["draft"] == true
        @schema = entry["input"].is_a?(Hash) ? entry["input"] : {}
        @discriminator = schema.dig("discriminator", "propertyName") if Array(schema["oneOf"]).any?
        if @discriminator
          checked_name(@discriminator, "#{key}'s discriminator")
          @inputs = []
          # The inputs that are an operation body in at least one branch. Only when there's one is
          # it positional, in every branch, so every branch's method takes the same shape.
          bodies = schema["oneOf"].flat_map do |branch|
            (branch["properties"] || {}).select { |_name, sub| self.class.operation(sub) }.keys
          end.uniq
          bodies |= (schema["properties"] || {}).select { |_name, sub| self.class.operation(sub) }.keys
          @body_name = bodies.size == 1 ? bodies.first : nil
          @branches = schema["oneOf"].map { |branch| branch_for(branch) }.sort_by(&:method)
          methods = @branches.flat_map { |branch| [branch.method, "#{branch.method}_input"] }
          duplicate = methods.tally.find { |_method, count| count > 1 }
          raise Error, "#{key}'s branches give two methods named #{duplicate.first}" if duplicate
        else
          @inputs = inputs_of(schema["properties"], schema["required"])
          @branches = []
        end
      end

      def discriminated?
        !@discriminator.nil?
      end

      # A $operation reference's id, or nil when schema isn't one.
      def self.operation(schema)
        id = schema.is_a?(Hash) ? schema["$operation"] : nil
        return nil unless id.is_a?(String)
        raise Error, "not an operation id: #{id.inspect}" unless id.match?(OPERATION)

        id
      end

      # An operation id's entry in this gem's QubeSync::Operations, as [entity class name,
      # action], or nil for one it doesn't know.
      def self.known_operation(id)
        entry = Operations::INDEX[id]
        return nil unless entry

        [Operations::ENTITIES.fetch(entry[:entity]).to_s, id.split(".", 2).last]
      end

      # The fields a $operation reference says its workflow sets itself (`set_by_workflow`).
      def self.set_by_workflow(schema)
        Array(schema["set_by_workflow"]).select { |field| field.is_a?(String) }.uniq.sort
      end

      # An operation's top-level params, {field => [RBS type, required]}, or nil for one this gem
      # doesn't know. The index loads on first use.
      def self.operation_fields(id)
        require_relative "../operations/fields"
        Operations::FIELDS[id]
      end

      # An object schema discriminated by one of its properties: its oneOf branches.
      def self.discriminated?(schema)
        schema.is_a?(Hash) && Array(schema["oneOf"]).any? && schema.dig("discriminator", "propertyName").is_a?(String)
      end

      # A discriminated object's branches, as [title, properties merged over the base's,
      # required], sorted by title.
      def self.branch_schemas(schema)
        base = schema["properties"] || {}
        schema["oneOf"].map do |branch|
          [branch["title"].to_s, base.merge(branch["properties"] || {}),
            (Array(schema["required"]) | Array(branch["required"])).sort]
        end.sort_by(&:first)
      end

      private

      def branch_for(branch)
        title = checked_name(branch["title"], "a branch title in #{key}")
        properties = (schema["properties"] || {}).merge(branch["properties"] || {})
        fixed = properties[@discriminator] || {}
        value = fixed.key?("const") ? fixed["const"] : Array(fixed["enum"]).first
        raise Error, "#{key}'s #{title} branch doesn't fix #{@discriminator} to a value" if value.nil?

        required = Array(schema["required"]) | Array(branch["required"])
        inputs = inputs_of(properties.reject { |name, _| name == @discriminator }, required)
        body = inputs.find { |input| input.name == @body_name }
        method = (MODULE_METHODS.include?(title) || title == "start") ? "#{title}_" : title
        Branch.new(title: title, method: method, value: value, inputs: inputs, body: body)
      end

      def inputs_of(properties, required)
        required = Array(required)
        (properties || {}).sort.map do |name, sub|
          Input.new(name: checked_name(name, "an input of #{key}"), schema: sub.is_a?(Hash) ? sub : {},
            required: required.include?(name))
        end
      end

      def checked_name(name, what)
        raise Error, "#{what} isn't a name QuBe Sync allows: #{name.inspect}" unless name.is_a?(String) && name.match?(NAME)

        name
      end
    end
  end
end
