# encoding: UTF-8

require 'spec_helper'

describe Item do
  describe '#set_tags' do
    before(:all) do
      @tags = ['Посуда', 'Одежда']
    end

    it 'Принимает несколько строк' do
      i = FactoryGirl.create :item
      i.set_tags *@tags
      i.tags.collect(&:name).sort.reverse.should == @tags
    end

    it 'Принимает массив строк' do
      i = FactoryGirl.create :item
      i.set_tags @tags
      i.tags.collect(&:name).sort.reverse.should == @tags
    end

    it 'Принимает строки с тэгами, разделенными запятыми' do
      i = FactoryGirl.create :item
      i.set_tags @tags.join(', ')
      i.tags.collect(&:name).sort.reverse.should == @tags
    end

    it 'Не создаёт дубликаты имеющихся тэгов' do
      i = FactoryGirl.create :item
      i.set_tags 'Баден', 'Баден'
      i.tags.collect(&:name).sort.reverse.should == ['Баден']
    end
  end
end
