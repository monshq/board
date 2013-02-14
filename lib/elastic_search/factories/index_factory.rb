
# module ElasticSearch
  class IndexFactory
    def self.items(index = nil)
      index = Index.new('items', ItemMapping.new, index)
      index.create
      index
    end
  end
# end