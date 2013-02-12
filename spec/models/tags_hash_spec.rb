# encoding: UTF-8

require 'spec_helper'
require 'benchmark'

describe TagsHash do

  describe '.get_tags_hash' do
    it 'генерирует md5 хеш массива отсортированных тегов и строки тех же тегов разделенных запятой (не сортированы)' do
      TagsHash.get_tags_hash(%w[a b c d]).should eq TagsHash.get_tags_hash(%w[b d a c])
    end
  end

  describe '.get_hashes' do
    it 'генерирует хеши всех возможных вариантов тегов, отсортированных по алфавиту' do
      tags = Random.rand(5..10).times.map{ FactoryGirl.attributes_for(:tag)[:name] }
      tags.uniq!
      n = tags.length
      hashes = TagsHash.get_hashes_with_relevance(tags)
      hashes.length.should eq 2**n - 1
    end

    it 'генерация хешей всех возможных вариантов из 10 тегов не должна превышать 1 секунду' do
      tags = 10.times.map{ FactoryGirl.attributes_for(:tag)[:name] }
      res = Benchmark.measure{ TagsHash.get_hashes_with_relevance(tags) }
      time = res.to_s.split
      time.first.to_f.should be < 1.0
    end
  end

end
