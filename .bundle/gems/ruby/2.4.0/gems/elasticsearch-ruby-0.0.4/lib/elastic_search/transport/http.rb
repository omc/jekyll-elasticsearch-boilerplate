require "net/http"
require "uri"

module ElasticSearch
  class HTTPTransport < TransportBase
    def execute(request)
      query_string = "?#{request.parameters.to_query}" if request.parameters.is_a?(Hash)
      http_request = get_class(request.method).new("#{request.path}#{query_string}")
      http_request.body = request.body
      response = current_connection.request(http_request)
      ElasticSearch::Response.new(body: response.body, status: response.code)
    end

    private
    def get_connection(host)
      uri = URI.parse(host)
      Net::HTTP.new(uri.host, uri.port)
    end

    def get_class(method)
      case method
      when :get then Net::HTTP::Get
      when :post then Net::HTTP::Post
      when :put then Net::HTTP::Put
      when :delete then Net::HTTP::Delete
      when :head then Net::HTTP::Head
      end
    end
  end
end
