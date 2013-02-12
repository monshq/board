# module ElasticSearch
  class SearchFactory
    def items
      Search.new("items2", {
        mapping: ItemMapping.new,
        query_builder_class: ItemsQueryBuilder,
        result_set_class: ItemsResultSet
      })
    end
  end
# end