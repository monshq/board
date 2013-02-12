# module ElasticSearch

  class ItemMapping

    def settings
    #   {
    #     index: {
    #       analysis: {
    #         analyzer: {
    #           skills: {
    #             type: "custom",
    #             tokenizer: "keyword",
    #             filter: ["standard", "lowercase"]
    #           },
    #           skills_words: {
    #             type: "custom",
    #             tokenizer: "keyword",
    #             filter: ["standard", "lowercase", "word_delimiter"]
    #           }
    #         }
    #       }
    #     }
    #   }
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
            # rate: { type: "integer" },
            # toptal_email: { type: "string" },
            # status: { type: "string", analyzer: "keyword" },
            # allocated_hours: { type: "integer" },
            # time_zone_name: { type: "string", analyzer: "keyword" },
            # about: { type: "string" },

            # all_skills: {type: "string", analyzer: "skills_words"},
            # expert_skills: { type: "string", analyzer: "skills", boost: 8 },
            # strong_skills: { type: "string", analyzer: "skills", boost: 4 },
            # competent_skills: { type: "string", analyzer: "skills", boost: 2 },

            # user: {
            #   properties: {
            #     full_name: { type: "string" },
            #     about: { type: "string", analyzer: "snowball" }
            #   }
            # }
          }
        }
      }
    end

    def transform(model)

      # expert_skill_names = model.expert_skills.map(&:name)
      # strong_skill_names = model.strong_skills.map(&:name)
      # competent_skill_names = model.competent_skills.map(&:name)

      {
        _type: "item",
        id: model.id,

        contact_info: model.contact_info,
        description: model.description
      }
    end

  end
# end
