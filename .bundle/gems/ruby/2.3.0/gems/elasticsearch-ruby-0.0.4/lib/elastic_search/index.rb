module ElasticSearch
  class Index
    attr_reader :index_name, :client

    def initialize(index_name, client)
      @index_name = index_name
      @client = client
      @types = {}
    end

    def get_type(type_name)
      @types[type_name.to_sym] ||= ElasticSearch::Type.new(type_name, self)
    end
    alias :[] :get_type

    def search(body, parameters = {})
      request = build_request(method: :get, action: :search, parameters: parameters, body: body || {})
      response = execute(request)
      ElasticSearch::Search::Results.new(response)
    end

    def refresh
      request = build_request(method: :post, action: :refresh)
      execute(request)
    end

    def open
      request = build_request(method: :post, action: :open)
      execute(request)
    end

    def close
      request = build_request(method: :post, action: :close)
      execute(request)
    end

    def settings
      request = build_request(method: :get, action: :settings)
      execute(request).body
    end

    def settings=(settings)
      request = build_request(method: :put, action: :settings, body: settings)
      execute(request)
    end

    def mapping
      request = build_request(method: :get, action: :mapping)
      execute(request).body
    end

    def mapping=(mapping)
      request = build_request(method: :put, action: :mapping, body: mapping)
      execute(request).status.eql?(200)
    end

    def optimize(options = {})
      request = build_request(method: :post, action: :optimize, parameters: options)
      execute(request).status.eql?(200)
    end

    def exists?
      @client.has_index?(@index_name)
    end

    def execute(request)
      @client.execute(request)
    end

    private
    def build_request(options = {})
      Request.new({ index: @index_name }.merge(options))
    end
  end
end
