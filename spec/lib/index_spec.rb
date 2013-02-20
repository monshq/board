# encoding: UTF-8

require 'spec_helper'

describe ElasticSearch::Index do
  before(:all) do
    @index_class = ElasticSearch::Index
    @mapping_class = ElasticSearch::Mappings::ItemMapping
  end

  describe 'create' do
    it 'Вызывает Tire::Index.create' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:create).and_return(true)
      index = @index_class.new("test_index", @mapping_class.new, tire_index_mock)
      index.create
    end
  end

  describe 'destroy' do
    it 'Вызывает Tire::Index.delete' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:delete).and_return(true)
      index = @index_class.new("test_index", @mapping_class.new, tire_index_mock)
      index.destroy
    end
  end

  describe 'store' do
    it 'Вызывает Tire::Index.store' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:store).and_return(true)
      index = @index_class.new("test_index", @mapping_class.new, tire_index_mock)
      index.store FactoryGirl.create(:item)
    end
  end

  describe 'remove' do
    it 'Вызывает Tire::Index.remove' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:remove).at_least(:once).and_return(true)
      index = @index_class.new("test_index", @mapping_class.new, tire_index_mock)
      index.remove FactoryGirl.create(:item)
    end
  end

  describe 'import_in_batches' do
    it 'Вызывает Tire::Index.bulk_store' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:bulk_store).and_return(true)
      index = @index_class.new("test_index", @mapping_class.new, tire_index_mock)
      3.times { FactoryGirl.create :item, state: :published }
      index.import_in_batches Item.published
    end
  end
end
