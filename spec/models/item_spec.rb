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
end
