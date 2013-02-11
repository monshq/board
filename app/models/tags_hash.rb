class TagsHash < ActiveRecord::Base
  require "digest"

  attr_accessible :tags_hash, :relevance

  belongs_to :item

  scope :archived, lambda { where("state = ?", :archived) }

  class << self
    def get_tags_hash(tags)
      if tags.kind_of?(String)
        tags = self.convert_tags_string_to_sorted_array_with_uniq_tags(tags)
      end
      Digest::MD5.hexdigest(tags.join)
    end

    def get_hashes(tags)
      tags = self.convert_tags_string_to_sorted_array_with_uniq_tags(tags)

      get_tags_combinations(tags).map do |combination|
        TagsHash.new(
          tags_hash: self.get_tags_hash(combination),
          relevance: tags.length-combination.length
        )
      end
    end
  end

private
  class << self
    def convert_tags_string_to_sorted_array_with_uniq_tags(tags)
      if tags.kind_of?(String)
        tags = tags.split(',').map { |t| t.strip }
      end
      tags.uniq.sort
    end

    def get_tags_combinations(tags)
       1.upto(tags.length).flat_map{ |len| tags.combination(len).to_a }
    end
  end
end
