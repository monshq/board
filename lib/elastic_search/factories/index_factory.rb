module ElasticSearch
  module Factories
    class IndexFactory
      def self.items(index = nil)
        index = Index.new(Settings.elastic.index.name, Mappings::ItemMapping.new, index)
        index.create
        index
      end
    end
  end
end
