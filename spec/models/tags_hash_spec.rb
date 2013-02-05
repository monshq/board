# encoding: UTF-8

require 'spec_helper'
require 'benchmark'

describe TagsHash do
  
  describe '.convert_tags_string_to_sorted_array_with_uniq_tags' do
    it 'конвертирует строку тегов разделенных запятой в отсортированный массив уникальных тегов' do
      tags = "3 ,4, 1, 2  ,3,1  ,4  "
      tags = TagsHash.convert_tags_string_to_sorted_array_with_uniq_tags(tags)
      tags.should == ["1","2","3","4"]
    end
  end

  describe '.get_tags_hash' do
    it 'генерирует md5 хеш массива отсортированных тегов и строки тех же тегов разделенных запятой (не сортированы)' do
      array_of_tags = ["a","b","c","d"]
      string_of_tags = ' a,c , d  ,b'
      TagsHash.get_tags_hash(array_of_tags).should eq TagsHash.get_tags_hash(string_of_tags)
    end
  end

  describe '.get_hashes' do
    it 'генерирует хеши всех возможных вариантов тегов, отсортированных по алфавиту' do
      tags = Random.rand(5..10).times.map{ FactoryGirl.attributes_for(:tag)[:name] }
      tags.uniq!
      n = tags.length
      hashes = TagsHash.get_hashes(tags)
      hashes.length.should eq 2**n - 1
    end

    it 'генерация хешей всех возможных вариантов из 10 тегов не должна превышать 1 секунду' do
      tags = 10.times.map{ FactoryGirl.attributes_for(:tag)[:name] }
      res = Benchmark.measure{ TagsHash.get_hashes(tags) }
      time = res.to_s.split
      time.first.to_f.should be < 1.0
    end
  end

end
