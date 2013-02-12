# module ElasticSearch
  class ItemsResultSet

    attr_reader :raw

    def initialize(tire_result)
      @raw = tire_result
    end

    def items
      raw.results
    end

    def ids
      raw.map{ |item| item.id.to_i }
    end

    def entities
      @entities ||= Item.find(ids)
    end

  end
# end
