module ElasticSearch
  class Response
    attr_reader :status

    def initialize(options)
      @body = options[:body].eql?("") ? "{}" : options[:body]
      @status = options[:status].to_i

      case @status
      when 200..206
      when 404
        if self.body['error'] =~ /^IndexMissingException/ || self.body.eql?(nil)
          raise ElasticSearch::IndexMissingException, "#{self.body['status']}: #{self.body['error']}"
        elsif self.body['exists'].eql?(false)
          raise ElasticSearch::ItemMissingException, "_id: #{self.body['id']} NOT FOUND"
        else
          raise ElasticSearch::NotFoundError
        end
      else
        raise ElasticSearch::ResponseError, "#{self.body['status']}: #{self.body['error']}"
      end
    end

    def body
      @decoded_body ||= (@body ? ActiveSupport::JSON.decode(@body) : {})
    end

    private
    def recursive_symbolize_keys!(hash)
      hash.symbolize_keys!
      hash.values.select{|v| v.is_a? Hash}.each{|h| recursive_symbolize_keys!(h)}
    end
  end

  class ResponseError < StandardError; end
  class NotFoundError < StandardError; end
  class IndexMissingException < NotFoundError; end
  class ItemMissingException < NotFoundError; end
end
