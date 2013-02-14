# module ElasticSearch
  class SearchFactory
    def self.items
      @items ||= Search.new("items", {
        mapping: ItemMapping.new,
        query_builder_class: ItemQueryBuilder
      })
    end
  end
# end