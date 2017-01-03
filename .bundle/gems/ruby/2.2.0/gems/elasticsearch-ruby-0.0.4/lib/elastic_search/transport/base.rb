module ElasticSearch
  class TransportBase
    def initialize(hosts, options = {})
      @options = options
      @connections =  hosts.collect { |host| get_connection(host) }
    end

    def current_connection
      @connections.sample
    end

    def execute(request)
      raise NotImplementedError
    end

    private
    def get_connection(host)
      raise NotImplementedError
    end
  end
end
