module ElasticSearch
  module Factories
    class IndexFactory
      def self.items(index = nil)
        index = Index.new('items', Mappings::ItemMapping.new, index)
        index.create
        index
      end
    end
  end
end
