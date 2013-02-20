module ElasticSearch
  module Mappings
    class ItemMapping

      def settings
        {}
      end

      def mappings
        {
          item: {
            properties: {
              id: { type: "integer", index: "not_analyzed" },
              contact_info: { type: "string", index: "analyzed" },
              description: { type: "string", index: "analyzed" },
              state: { type: "string", index: "not_analyzed" }
            }
          }
        }
      end

      def transform(model)
        {
          _type: "item",
          id: model.id,

          contact_info: model.contact_info,
          description: model.description,
          state: model.state
        }
      end

    end
  end
end
