
# module ElasticSearch
  class IndexFactory
    def items
      Index.new('items2', ItemMapping.new)
    end
  end
# end