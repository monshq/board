# encoding: UTF-8

require 'spec_helper'

describe Tag do
  describe '#name=' do
    it 'Обрезает лишние пробелы' do
      t = FactoryGirl.create :tag, name: '  Свобода  '
      t.name.should == 'Свобода'
    end
  end
end
