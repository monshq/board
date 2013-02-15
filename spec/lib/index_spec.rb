# encoding: UTF-8

require 'spec_helper'

describe Index do
  describe 'create' do
    it 'Вызывает Tire::Index.create' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:create).and_return(true)
      index = Index.new("test_index", ItemMapping.new, tire_index_mock)
      index.create
    end
  end

  describe 'destroy' do
    it 'Вызывает Tire::Index.delete' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:delete).and_return(true)
      index = Index.new("test_index", ItemMapping.new, tire_index_mock)
      index.destroy
    end
  end

  describe 'store' do
    it 'Вызывает Tire::Index.store' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:store).and_return(true)
      index = Index.new("test_index", ItemMapping.new, tire_index_mock)
      index.store FactoryGirl.create(:item)
    end
  end

  describe 'remove' do
    it 'Вызывает Tire::Index.remove' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:remove).and_return(true)
      index = Index.new("test_index", ItemMapping.new, tire_index_mock)
      index.remove FactoryGirl.create(:item)
    end
  end

  describe 'import_in_batches' do
    it 'Вызывает Tire::Index.bulk_store' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:bulk_store).and_return(true)
      index = Index.new("test_index", ItemMapping.new, tire_index_mock)
      3.times { FactoryGirl.create :item, state: :published }
      index.import_in_batches Item.published
    end
  end
end
