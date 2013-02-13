
# module ElasticSearch
  class IndexFactory
    def items
      index = Index.new('items', ItemMapping.new)
      index.create_if_not_exists
      index
    end
  end
# end