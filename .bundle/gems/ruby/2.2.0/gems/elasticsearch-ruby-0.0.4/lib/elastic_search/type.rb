module ElasticSearch
  class Type
    def initialize(type_name, index)
      @type_name = type_name
      @index = index
    end

    def search(body, parameters = {})
      request = build_request({ method: :get, action: :search, parameters: parameters, body: body || {} })
      response = execute(request)
      ElasticSearch::Search::Results.new(response)
    end

    def put(id, doc)
      request = build_request({ method: :put, id: id.to_s, body: doc })
      execute(request)
    end
    alias :index :put

    def get(id)
      request = build_request({ method: :get, id: id.to_s })
      response = execute(request)
      ElasticSearch::Item.new(response)
    end

    def delete(id)
      request = build_request({ method: :delete, id: id.to_s })
      execute(request)
    end

    def delete_by_query(body, parameters = {})
      request = build_request({ method: :delete, action: :search, parameters: parameters, body: body || {} })
      execute(request)
    end

    def update(id, body, parameters = {})
      request = build_request({ method: :post, id: id.to_s, action: :update, parameters: parameters, body: doc })
      execute(request)
    end

    def count(parameters = {})
      request = build_request({ method: :post, action: :update, id: id.to_s, body: doc })
      execute(request).body['count']
    end

    def more_like_this(id, parameters = {})
      request = build_request({ method: :get, id: id.to_s, action: :mlt, parameters: parameters, body: doc })
    end

    def mapping
      request = build_request(method: :get, action: :mapping)
      execute(request).body
    end

    def mapping=(mapping)
      request = build_request(method: :put, action: :mapping, body: mapping)
      execute(request).status.eql?(200)
    end

    def delete_mapping
      request = build_request({ method: :delete })
      execute(request).status.eql?(200)
    end

    def execute(request)
      @index.client.execute(request)
    end

    private
    def build_request(parameters = {})
      Request.new({ index: @index.index_name, type: @type_name }.merge(parameters))
    end
  end
end
