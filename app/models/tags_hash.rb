class TagsHash < ActiveRecord::Base
  require "digest"

  attr_accessible :tags_hash, :relevance

  belongs_to :item

  class << self
    def get_tags_hash(tags)
      Digest::MD5.hexdigest(tags.uniq.sort.join)
    end

    def get_hashes_with_relevance(tags)
      get_tags_combinations(tags.uniq.sort).map do |combination|
        {hash: Digest::MD5.hexdigest(combination.join), relevance: tags.length - combination.length}
      end
    end
  end

private
  class << self
    def get_tags_combinations(tags)
       1.upto(tags.length).flat_map{ |len| tags.combination(len).to_a }
    end
  end
end
