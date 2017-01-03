require 'spec_helper'

describe ElasticSearch::Index do
  TRANSPORT_CONTEXTS.each do |transport, context|
    describe context do
      let :client do
        ElasticSearch::Client.new(transport)
      end

      let :index do
        client[TEST_INDEX]
      end

      before do
        client.create_index(TEST_INDEX).refresh
      end

      after do
        begin
          client.delete_index(TEST_INDEX)
        rescue ElasticSearch::IndexMissingException
        end
      end

      describe :search do
        it "should return results" do
          index['type_1'].put(1, { foo: 'bar' })
          index['type_2'].put(2, { foo: 'baz' })
          index.refresh
          results = index.search(nil, q: '*')
          results.must_be_instance_of ElasticSearch::Search::Results
        end

        it "should return the total" do
          (1..20).each { |i| index['type'].put(i, { foo: 'bar' }) }
          index.refresh
          results = index.search(nil, q: '*')
          results.total.must_equal 20
          results.count.must_equal 10
        end

        it "should know the type of results" do
          index['type_1'].put(1, { foo: 'bar' })
          index.refresh
          results = index.search(nil, q: '*')
          results[0].type.must_equal 'type_1'
        end

        it "should search using the body" do
          index[TEST_TYPE].put(1, { foo: 'bar' })
          index.refresh
          results = index.search({ query: { query_string: { query: '*' } } })
          results.count.must_equal 1
        end
      end

      describe :refresh do
        it "should refresh the index" do
          index.refresh
        end
      end

      describe :open do
        it "should not raise an error if index is open" do
          index.close
          index.open
          index[TEST_TYPE].put(1, { foo: 'bar' })
        end
      end

      describe :close do
        it "should throw an error when trying to put into a closed index" do
          index.close
          proc { index[TEST_TYPE].put(1, { foo: 'bar' }) }.must_raise ElasticSearch::ResponseError
        end
      end

      describe :settings do
        it "should return the index settings"
      end

      describe :settings= do
        it "should set the index settings"
      end

      describe :mapping do
        it "should return the mapping" do
          index[:tweet].mapping = { tweet: { properties: { message: { type: 'string' } } } }
          index.mapping[TEST_INDEX]['tweet']['properties']['message']['type'].must_equal 'string'
        end
      end

      describe :mapping= do
        it "should set the index mapping"
      end

      describe :delete_mapping do
        it "should set delete the index mapping"
      end

      describe :optimize do
        it "should optimize the index"
      end

      describe :exists? do
        it "should check if the index exists" do
          index.exists?.must_equal true
          client.delete_index(TEST_INDEX)
          index.exists?.must_equal false
        end
      end
    end
  end
end
