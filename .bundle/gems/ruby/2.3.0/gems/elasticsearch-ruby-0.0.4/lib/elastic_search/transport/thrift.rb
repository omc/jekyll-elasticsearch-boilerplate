require 'thrift'
require 'elastic_search/thrift/elastic_search_constants'
require 'elastic_search/thrift/elastic_search_types'
require 'elastic_search/thrift/rest'

module ElasticSearch
  class ThriftTransport < TransportBase
    def execute(request)
      thrift_request = ElasticSearch::Thrift::RestRequest.new
      thrift_request.method = get_method(request.method)
      thrift_request.uri = request.path
      thrift_request.body = request.body
      thrift_request.parameters = request.parameters
      response = current_connection.execute(thrift_request)
      ElasticSearch::Response.new(body: response.body, status: response.status)
    end

    private
    def get_method(method)
      case method
      when :get then ElasticSearch::Thrift::Method::GET
      when :post then ElasticSearch::Thrift::Method::POST
      when :put then ElasticSearch::Thrift::Method::PUT
      when :delete then ElasticSearch::Thrift::Method::DELETE
      when :head then ElasticSearch::Thrift::Method::HEAD
      end
    end

    def get_connection(host)
      host, port = host.to_s.split(":")
      transport = ::Thrift::Socket.new(host, port.to_i, @options[:timeout])
      buffered_transport = ::Thrift::BufferedTransport.new(transport)
      buffered_transport.open
      protocol = ::Thrift::BinaryProtocol.new(buffered_transport)
      ElasticSearch::Thrift::Rest::Client.new(protocol)
    end
  end
end
