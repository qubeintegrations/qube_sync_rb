module QubeSync
  class RequestBuilder
    attr_reader :version, :root

    def initialize(version:, &block)
      @version = version
      @stack = []
      yield self if block_given?
    end

    def method_missing(tag_name, *args, &block)
      attributes = args.first.is_a?(Hash) ? args.first : {}
      text = args.first unless args.first.is_a?(Hash)
      
      element = {
        "name" => tag_name.to_s,
      }
      element["attributes"] = attributes unless attributes.empty?
      # qbXML's booleans are the words true and false.
      text = text.to_s if text == true || text == false
      element["text"] = text if text.is_a?(String) || text.is_a?(Numeric)

      if block_given?
        element["children"] = []
        @stack.push(element)
        block.call
        @stack.pop
      end

      if @stack.empty?
        @root ||= []
        @root << element
      else
        @stack.last["children"] << element
      end
    end

    def as_json
      {
        "version" => version,
        "request" => root
      }
    end

    private

    def root
      @root || []
    end
  end
end
