# encoding: UTF-8

require 'spec_helper'

describe Item do
  describe '#set_tags' do
    before(:all) do
      @tags = ['Одежда', 'Посуда']
    end

    before(:each) do
      @i = FactoryGirl.create :item
    end

    it 'Принимает строку с тэгами, разделенными запятыми' do
      @i.set_tags @tags.join(', ')
      @i.tags.collect(&:name).sort.should == @tags
    end

    it 'Не создаёт дубликаты имеющихся тэгов' do
      @i.set_tags 'Баден, Баден'
      @i.tags.collect(&:name).should == ['Баден']
    end

    it 'Принимает пустую строку, но ничего не делает' do
      expect {@i.set_tags ''}.not_to change {@i.tags.count}
    end
  end

  describe '#set_tags_hashes' do
    before(:each) do
      @i = FactoryGirl.create :item
      @tags = '1,5,7,2,8,4,0,2'
      @i.set_tags @tags
    end
    
    it 'adds hashes of all combinations of tags' do
      @i.set_tags_hashes
      @i.tags_hashes.length.should eq 127
    end
  end

  describe '#find_by_tags' do
    before(:each) do
      @i = FactoryGirl.create :item
      @tags = '1,5,7,2,8,4,0,2'
      @i.set_tags @tags
    end
    
    it 'ищет объявление, у которого есть все перечисленные теги' do
      @i.set_tags_hashes
      items = Item.find_by_tags('5,2,1,8,4,0,7')
      
      items[0].should eq @i
    end
  end

  describe 'item state_machine' do
    before(:each) do
      @i = FactoryGirl.create :item
    end
    
    it "publishes an item" do
      @i.publish
      @i.should be_visible
      @i.should be_visible_for_seller
      @i.state.should eq 'published'
    end

    it "hides an item" do
      @i.hide
      @i.should_not be_visible
      @i.should be_visible_for_seller
      @i.state.should eq 'hidden'
    end

    it "sells a published item" do
      @i.publish
      @i.should be_visible
      @i.sell
      @i.should_not be_visible
      @i.should be_visible_for_seller
      @i.state.should eq 'sold'
    end

    it "sells a hidden item" do
      @i.sell
      @i.should_not be_visible
      @i.should be_visible_for_seller
      @i.state.should eq 'sold'
    end

    it "tries to publish a sold item" do
      @i.sell
      @i.publish
      @i.should_not be_visible
      @i.should be_visible_for_seller
      @i.state.should eq 'sold'
    end

    it "archivates an item and it becomes invisible for a seller and buyer" do
      @i.archivate
      @i.should_not be_visible
      @i.should_not be_visible_for_seller
      @i.state.should eq 'archived'
    end

    it "remove tags" do
      item = FactoryGirl.create(:item)
      item.set_tags 'Animal'
      item.set_tags 'People'
      item.tags.map(&:name).should eq ['People']
    end
  end
  
end
