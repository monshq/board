# encoding: UTF-8

require 'spec_helper'

describe Transaction do
  describe 'Состояния транзкции' do
    before(:each) do
      @t = FactoryGirl.create :transaction
      @t.item.reserve
    end
    
    it "Из начального состояния переход только в 'принято' и 'отвергнуто'" do
      @t.state_transitions.select{ |t| [:accepted, :rejected].include? t.to_name }.length.should == 2
      @t.state_transitions.select{ |t| ![:accepted, :rejected].include? t.to_name }.length.should == 0
    end
    
    it "При переходе в состояние 'принято' объявление должно быть продано" do
      @t.accept
      @t.item.state.should == 'sold'
    end
    
    it "При переходе в состояние 'отвергнуто' объявление возвращается к опубликованным" do
      @t.reject
      @t.item.state.should eq 'published'
    end
    
    it "Переходов из состояния 'принято' нет" do
      @t.accept
      @t.state_transitions.length.should == 0
    end
    
    it "Переходов из состояния 'отвергнуто' нет" do
      @t.reject
      @t.state_transitions.length.should == 0
    end
  end
end
