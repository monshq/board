# encoding: UTF-8

require 'spec_helper'

describe ElasticSearch::ModelPresenter do
  before(:all) do
    @model_presenter_class = ElasticSearch::ModelPresenter
    @item_mapping_class = ElasticSearch::Mappings::ItemMapping
  end

  describe 'to_indexed_json' do
    it 'Возвращает json для модели' do
      item = FactoryGirl.create :item, contact_info: '12345678901', description: 'N'
      presenter = @model_presenter_class.new(item, @item_mapping_class.new)
      presenter.to_indexed_json.should ==
        "{\"_type\":\"item\",\"id\":1,\"contact_info\":\"12345678901\",\"description\":\"N\"}"
    end
  end

  describe 'id' do
    it 'Возвращает id для модели' do
      item = FactoryGirl.create :item
      presenter = @model_presenter_class.new(item, @item_mapping_class.new)
      presenter.id.should == item.id
    end
  end

  describe 'document_type' do
    it "Возвращает 'item' для Item" do
      item = FactoryGirl.create :item
      presenter = @model_presenter_class.new(item, @item_mapping_class.new)
      presenter.document_type.should == 'item'
    end
  end
end
