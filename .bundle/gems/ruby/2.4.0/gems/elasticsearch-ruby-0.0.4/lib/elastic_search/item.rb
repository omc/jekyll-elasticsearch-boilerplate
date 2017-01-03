module ElasticSearch
  class Item < HashWithIndifferentAccess
    attr_reader :index, :type, :item, :version, :exists

    def initialize(request)
      @index = request.body['_index']
      @type = request.body['_type']
      @item = request.body['_id']
      @version = request.body['_version']
      @exists = request.body['exists']
      self.replace(request.body['_source'])
    end
  end
end
