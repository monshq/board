module ElasticSearch
  module Factories
    class SearchFactory
      def self.items
        @items ||= Search.new("items", {
          mapping: Mappings::ItemMapping.new,
          query_builder_class: QueryBuilders::ItemQueryBuilder
        })
      end
    end
  end
end
