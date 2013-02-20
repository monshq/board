
module ElasticSearch
  class Index

    class Error < RuntimeError; end

    attr_reader :name, :mapping

    def initialize(name, mapping, index = nil)
      @name = name
      @mapping = mapping
      @settings = mapping.try(:settings) || {}
      @index = index || Tire::Index.new(@name)
    end

    def create
      options = { mappings: @mapping.mappings, settings: @settings }
      @index.create options
    end

    def import(collection)
      @index.bulk_store(collection.map{ |entity| presenter_for(entity) })
    end

    def remove(entity)
      @index.remove(presenter_for(entity))
    end

    def store(item)
      @index.store(presenter_for(item))
    end

    def destroy
      @index.delete
    end

    private

    def presenter_for(entity)
      ModelPresenter.new(entity, @mapping)
    end

  end
end
