require "bundler/setup"
require 'minitest/spec'
require 'minitest/mock'
require 'turn/autorun'
require 'active_support/all'

require 'elastic_search'

class MiniTest::Spec
  alias :method_name :__name__ if defined? :__name__

  class << self
    alias :context :describe
  end
end

Turn.config.format = :progress
Turn.config.natural = true

TEST_INDEX = 'test_index'
TEST_TYPE = 'test_type'

TRANSPORT_CONTEXTS = [
  [ElasticSearch::ThriftTransport.new(['localhost:9500']), 'Using Thrift'],
  [ElasticSearch::HTTPTransport.new(['http://localhost:9200']), 'Using HTTP']
]
