# encoding: UTF-8

require 'spec_helper'

describe IndexerObserver do

  describe 'add_to_index' do
    it 'Вызывает ElasticSearch::Index.store' do
      item = FactoryGirl.create :item
      ElasticSearch::Index.any_instance.should_receive(:store)
      IndexerObserver.instance.add_to_index(item)
    end

    it 'Не выбрасывает исключений при ошибке' do
      expect { IndexerObserver.instance.add_to_index(nil) }.not_to raise_error
    end
  end

  describe 'remove_from_index' do
    it 'Вызывает ElasticSearch::Index.remove' do
      item = FactoryGirl.create :item
      ElasticSearch::Index.any_instance.should_receive(:remove).at_least(:once).with(item)
      expect { IndexerObserver.instance.remove_from_index(item) }.not_to raise_error
    end

    it 'Не выбрасывает исключений при ошибке' do
      expect { IndexerObserver.instance.remove_from_index(nil) }.not_to raise_error
    end
  end
end
