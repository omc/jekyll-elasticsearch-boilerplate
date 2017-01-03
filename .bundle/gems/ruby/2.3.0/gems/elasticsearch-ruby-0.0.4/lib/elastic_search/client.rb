module ElasticSearch
  class Client
    def initialize(transport)
      @transport = transport
      @indexes = {}
    end

    def get_index(index_name)
      @indexes[index_name.to_sym] ||= ElasticSearch::Index.new(index_name, self)
    end
    alias :[] :get_index

    def create_index(index_name, options = {})
      body = { mappings: options[:mappings], settings: options[:settings] }.reject { |_, v| v.nil? }
      request = Request.new({ method: :post, index: index_name, body: body })
      status = self.execute(request).status
      get_index(index_name) if status.eql?(200) || status.eql?(201)
    end

    def delete_index(index_name)
      request = Request.new({ method: :delete, index: index_name })
      execute(request)
    end

    def has_index?(index_name)
      request = Request.new({ method: :head, index: index_name })
      begin
        execute(request).status.between?(200, 206)
      rescue ElasticSearch::NotFoundError
        return false
      end
    end

    def bulk(objects)
      body = objects.flatten.join("\n") + "\n"
      request = Request.new({ method: :post, action: :bulk, body: body })
      execute(request)
    end

    def execute(request)
      @transport.execute(request)
    end
  end
end
