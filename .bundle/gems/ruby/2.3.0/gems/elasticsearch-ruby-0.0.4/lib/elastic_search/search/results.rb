module ElasticSearch
  module Search
    class Results < Array
      attr_reader :took, :timed_out, :shards, :total, :max_score

      def initialize(response)
        @took = response.body['took']
        @timed_out = response.body['timed_out']
        @shards = response.body['shards']
        @total = response.body['hits']['total']
        @max_score = response.body['hits']['max_score']
        self.replace(response.body['hits']['hits'].collect { |h| ResultItem.new(h) })
      end
    end

    class ResultItem < HashWithIndifferentAccess
      attr_reader :index, :type, :id, :score, :explanation

      def initialize(hit)
        @index = hit['_index']
        @type = hit['_type']
        @id = hit['_id']
        @score = hit['_score']
        @explanation = hit ['_explanation']
        self.replace(hit['_source'])
      end
    end
  end
end
