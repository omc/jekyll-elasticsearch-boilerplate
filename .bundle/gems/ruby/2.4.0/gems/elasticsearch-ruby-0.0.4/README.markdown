# elasticsearch-client

An elastic search ruby library with multiple transport support originall built
for use with [SoundTracking](http://www.soundtracking.com/).

> DISCLAIMER: Quite a bit more work to be done till production ready, use at your own
> risk! :)

Installation
------------

    $ gem install elasticsearch-ruby

Usage
-----

```ruby

transport = ElasticSearch::HTTPTransport.new(['http://localhost:9200'])
client = ElasticSearch::Client.new(transport)

index = client.create_index('twitter')
index['tweet'].put(1, { foo: 'bar' })

query = { query: { query_string: { query: 'bar' } } }
results = index['tweet'].search

results.total                         # 1

results.each do |result|
  result.score                        # 1.0
  result['foo']                       # bar
end

client['twitter'].search(query).type  # 'tweet'

```

TODO:
-----

* Better configuration support
* Failover and retry code
* Better unicode suppoort with Thrift
* Support for Memcache Transport
* Query Builder and block support
* Stats, Health lookup methods
* Better error handling
* Documentation
