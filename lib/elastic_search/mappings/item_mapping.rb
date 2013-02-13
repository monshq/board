# module ElasticSearch

  class ItemMapping

    def settings
      {}
    end

    def full_text_search_fields
      %w{
        description
        contact_info
      }
    end

    def mappings
      {
        item: {
          properties: {
            id: { type: "integer", index: "not_analyzed" },
            contact_info: { type: "string", index: "analyzed" },
            description: { type: "string", index: "analyzed" }
          }
        }
      }
    end

    def transform(model)
      {
        _type: "item",
        id: model.id,

        contact_info: model.contact_info,
        description: model.description
      }
    end

  end
# end
