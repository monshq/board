# module ElasticSearch
  class SearchFactory
    def self.items
      @items ||= Search.new("items", {
        mapping: ItemMapping.new,
        query_builder_class: ItemsQueryBuilder,
        result_set_class: ItemsResultSet
      })
    end
  end
# end