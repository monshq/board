module ElasticSearch
  module QueryBuilders
    class ItemQueryBuilder

      def initialize(options, mapping)
        @options = options
        @mapping = mapping
      end

      def to_proc

        # To get some things with us into proc's enclosure
        options = @options
        mapping = @mapping

        Proc.new do
          # http://www.elasticsearch.org/guide/reference/query-dsl/
          query do
            if options[:q].present?
              # http://www.elasticsearch.org/guide/reference/query-dsl/query-string-query.html
              string options[:q], fields: mapping.full_text_search_fields, use_dis_max: false
            end
          end

          size options[:limit].presence || 30
        end
      end

    end
  end
end
