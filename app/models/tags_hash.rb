class TagsHash < ActiveRecord::Base
  require "digest"
  
  belongs_to :item
  attr_accessible :tags_hash, :relevance

  scope :archived, lambda { where("state = ?", :archived) }

  def self.sort_tags(tags)
    tags = self.convert_tags_string_to_sorted_array(tags)
  end

  def self.get_tags_hash(tags)
    if tags.kind_of?(String)
      tags = self.convert_tags_string_to_sorted_array(tags)
    end
    hash = Digest::MD5.hexdigest(tags.join)
  end

  def self.convert_tags_string_to_sorted_array(tags)
    if tags.kind_of?(String)
      _tags = []
      tags.split(',').each do |t|
        _tags << t.strip
      end
      tags = _tags
    end
    tags.sort!
  end

  def self.get_hashes(tags, relevance=0, cache=nil)
    if cache == nil
      cache = HashCache.new
      self.sort_tags(tags)
    end
    hash = self.get_tags_hash(tags)
    unless cache.include?(hash)
      cache.add(hash)
      hashes = [TagsHash.new({tags_hash: hash, relevance: relevance})]
      tags.length.times do |i|
        tags_copy = Array.new(tags)
        tags_copy.delete_at(i)
        if tags_copy.length > 0
          nested_hashes = self.get_hashes(tags_copy, relevance+1, cache)
          hashes.concat(nested_hashes) if nested_hashes
        end
      end
      hashes
    else
      false
    end
  end
end
