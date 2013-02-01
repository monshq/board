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
      #cache = HashCache.new
      cache = {}
      self.sort_tags(tags)
    end
    hash = self.get_tags_hash(tags)
    #if cache.include?(hash)
    if cache.has_key?(hash)
      return false
    end
    #cache.add(hash)
    cache[hash] = nil
    hashes = [TagsHash.new({tags_hash: hash, relevance: relevance})]
    iter = tags.length - 1
    for i in 0..iter
      _tags = Array.new(tags)
      _tags.delete_at(i)
      if _tags.length > 0
        res = self.get_hashes(_tags, relevance+1, cache)
        if res
          hashes.concat(res)
        end
      end
    end
    hashes
  end
end
