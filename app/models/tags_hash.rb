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
      hash = Digest::MD5.hexdigest(tags.join)
    end

    def get_hashes(tags, relevance=0, calculated_hashes={})
      # sort array only one time, when it is a first call of .get_hashes
      if relevance == 0
        tags = self.convert_tags_string_to_sorted_array_with_uniq_tags(tags)
      end
      hashes = []

      hash = self.get_tags_hash(tags)
      unless calculated_hashes.include?(hash)
        calculated_hashes[hash] = nil
        hashes << TagsHash.new(tags_hash: hash, relevance: relevance)
        tags.length.times do |i|
          tags_copy = Array.new(tags)
          tags_copy.delete_at(i)
          if tags_copy.length > 0
            nested_hashes = self.get_hashes(tags_copy, relevance+1, calculated_hashes)
            hashes.concat(nested_hashes)
          end
        end
      end
      hashes
    end
  end

private
  class << self
    def convert_tags_string_to_sorted_array_with_uniq_tags(tags)
      if tags.kind_of?(String)
        tags_array = []
        tags.split(',').each { |t| tags_array << t.strip }
        tags = tags_array
      end
      tags.uniq.sort
    end
  end

end
