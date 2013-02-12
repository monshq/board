# module ElasticSearch
  class Search

    attr_reader :indices, :options

    def initialize(indices, options = {})
      @indices = [indices].flatten
      @options = options
      @mapping = options[:mapping]
      @query_builder_klass = options[:query_builder_class]
      @result_set_klass = options[:result_set_class]
    end

    def search(query_options)
      @result_set_klass.new(build_search(query_options).results)
    end

    private

    def build_search(options)
      query_builder = @query_builder_klass.new(options, @mapping)
      if query_builder.respond_to?(:to_proc) 
        Tire::Search::Search.new(@indices, &query_builder.to_proc)
      else
        raise RuntimeError.new("Invalid query builder. Should respond to #to_proc")
      end
    end

  end
# end
