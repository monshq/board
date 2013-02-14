# module ElasticSearch
  class Search

    attr_reader :indices, :options

    def initialize(indices, options = {}, search_class = Tire::Search::Search)
      @indices = [indices].flatten
      @options = options
      @mapping = options[:mapping]
      @query_builder_klass = options[:query_builder_class]
      @search_class = search_class
    end

    def search(query_options)
      build_search(query_options).results.results
    end

    private

    def build_search(options)
      query_builder = @query_builder_klass.new(options, @mapping)
      if query_builder.respond_to?(:to_proc) 
        @search_class.new(@indices, &query_builder.to_proc)
      end
    end

  end
# end
