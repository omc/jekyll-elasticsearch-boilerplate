module ElasticSearch
  class Request
    attr_reader :method, :index, :type, :id, :action

    def initialize(options = {})
      @method = options[:method] ? options[:method].to_sym : :get
      @index = options[:index]
      @type = options[:type]
      @id = options[:id]
      @action = options[:action]
      @parameters = options[:parameters]
      @body = options[:body]
    end

    def parameters
      @stringified_parameters ||= @parameters.inject({}) do |options, (key, value)|
        options[key.to_s] = value.to_s
        options
      end if @parameters
    end

    def body
      @encoded_body ||= @body.is_a?(String) ? @body : @body.to_json
    end

    def path
      components = [@index, @type, @id]
      components << "_#{@action.to_s}" if @action
      "/#{components.compact.join("/")}"
    end
  end
end
