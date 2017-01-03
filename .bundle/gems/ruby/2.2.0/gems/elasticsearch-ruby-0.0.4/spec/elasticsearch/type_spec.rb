require 'spec_helper'

describe ElasticSearch::Type do
  TRANSPORT_CONTEXTS.each do |transport, context|
    describe context do
      let :client do
        ElasticSearch::Client.new(transport)
      end

      let :index do
        client[TEST_INDEX]
      end

      let :type do
        index[TEST_TYPE]
      end

      before do
        client.create_index(TEST_INDEX).refresh
      end

      after do
        begin client.delete_index(TEST_INDEX) end
      end

      describe :put do
        it "should index a document" do
          type.put(1, { foo: 'bar' })
          index.refresh
          type.get(1)['foo'].must_equal 'bar'
        end
      end

      describe :get do
        it "should return an error if document does not exist"
      end

      describe :search do
        it "should return results" do
          type.put(1, { foo: 'bar' })
          type.put(2, { foo: 'baz' })
          index.refresh
          results = type.search(nil, q: '*')
          results.must_be_instance_of ElasticSearch::Search::Results
        end

        it "should return the total" do
          (1..20).each { |i| type.put(i, { foo: 'bar' }) }
          index.refresh
          results = type.search(nil, q: '*')
          results.total.must_equal 20
          results.count.must_equal 10
        end

        it "should return an explanation if explain is passed as a parameter" do
          type.put(1, { foo: 'bar' })
          index.refresh
          results = type.search(nil, q: 'bar', explain: true)
          results.first.explanation.must_be_kind_of Hash
        end
      end
    end
  end
end
