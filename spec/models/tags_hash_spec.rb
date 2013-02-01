# encoding: UTF-8

require 'spec_helper'
require 'benchmark'

describe TagsHash do
  
  describe '#sort_tags' do
    tags = [3,4,1,2]
    TagsHash.sort_tags(tags)
    tags.should == [1,2,3,4]
  end

  describe '#get_tags_hash' do
    it 'генерирует md5 хеш массива тегов' do
      tags = ["a","b","c","d"]
      TagsHash.get_tags_hash(tags).should eq 'e2fc714c4727ee9395f324cd2e7f331f'

      tags = ' a,c , d  ,b'
      TagsHash.get_tags_hash(tags).should eq 'e2fc714c4727ee9395f324cd2e7f331f'
    end
  end

  describe '#get_hashes' do
    it 'генерирует хеши всех возможных вариантов тегов, отсортированных по алфавиту' do
      tags = [3,4,1,2]
      
      hashes = TagsHash.get_hashes(tags)
      hashes.length.should eq 15

      tags << 5

      TagsHash.get_hashes(tags, 0).length.should eq 31
    end

    it 'мереет время генерации всех вариантов хешей' do
      tags = [3,4,1,2,5,8,6,7,9,10,11,12,13,14,15,16,17]
      #tags = [3,4,1,2]

      res = Benchmark.measure{ @hashes = TagsHash.get_hashes(tags) }
      p @hashes.length
      p res.inspect
    end

  end
end
