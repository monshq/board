
# encoding: UTF-8

require 'spec_helper'

describe ItemSearch do

  describe 'published' do
    it 'should call Tire::Search::Search.filter and return self' do
      search = mock('TireSearch')
      search.should_receive(:filter)
      search.should_receive(:size).once
      is = ItemSearch.new(search)
      is.archived.should eq is
    end
  end

  describe 'archived' do
    it 'should call Tire::Search::Search.filter and return self' do
      search = mock('TireSearch')
      search.should_receive(:filter)
      search.should_receive(:size).once
      is = ItemSearch.new(search)
      is.published.should eq is
    end
  end

  describe 'raw_result' do
    it 'should call Tire::Search::Search.results' do
      search = mock('TireSearch')
      search.should_receive(:results)
      search.should_receive(:size).once
      is = ItemSearch.new(search)
      is.raw_result
    end
  end

  describe 'with_keywords' do
    it 'should call Tire::Search::Search.query and return self' do
      search = mock('TireSearch')
      search.should_receive(:query)
      search.should_receive(:size).once
      is = ItemSearch.new(search)
      is.with_keywords('')
    end
  end

end
