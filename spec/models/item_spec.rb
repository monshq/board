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
  end
  
end
