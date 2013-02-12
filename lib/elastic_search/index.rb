# require(Rails.root.to_s + '/lib/elastic_search/factories/index_factory.rb')
# require './factories/index_factory'

# module ElasticSearch
  class Index

    class Error < RuntimeError; end

    attr_reader :name, :mapping

    def initialize(name, mapping)
      @name = name
      @mapping = mapping
      @settings = mapping.try(:settings) || {}
    end

    def create
      raise Error.new("already exists") if index.exists?
      options = { mappings: @mapping.mappings, settings: @settings }
      index.create(options) or raise Error.new(last_response.body)
    end

    def import_in_batches(scope)
      scope.find_in_batches{ |group| import(group) }
    end

    def import(collection)
      store_documents(collection.map{ |entity| presenter_for(entity) })
    end

    def remove(entity)
      index.remove(presenter_for(entity))
    end

    def store_documents(documents)
      index.bulk_store(documents)
    end

    def destroy
      index.delete
    end

    def last_response
      index.response
    end

    private

    def index
      @index ||= Tire::Index.new(@name)
    end

    def presenter_for(entity)
      ModelPresenter.new(entity, @mapping)
    end

  end
# end
