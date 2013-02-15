# encoding: UTF-8

require 'spec_helper'

describe ItemQueryBuilder do
  describe 'to_indexed_json' do
    it 'Возвращает json для модели' do
      item = FactoryGirl.create :item, contact_info: '12345678901', description: 'N'
      presenter = ModelPresenter.new(item, ItemMapping.new)
      presenter.to_indexed_json.should ==
        "{\"_type\":\"item\",\"id\":1,\"contact_info\":\"12345678901\",\"description\":\"N\"}"
    end
  end

  describe 'id' do
    it 'Возвращает id для модели' do
      item = FactoryGirl.create :item
      presenter = ModelPresenter.new(item, ItemMapping.new)
      presenter.id.should == item.id
    end
  end

  describe 'document_type' do
    it "Возвращает 'item' для Item" do
      item = FactoryGirl.create :item
      presenter = ModelPresenter.new(item, ItemMapping.new)
      presenter.document_type.should == 'item'
    end
  end
end
