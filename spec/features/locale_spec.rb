# encoding: UTF-8

require 'spec_helper'

feature 'Я хочу подать объявление на сайте на русском языке' do
  scenario 'Я захожу на сайт' do
    visit '/'
    current_path.should == "/#{I18n.locale}"
  end

  scenario 'Хочу поменять язык на русский, если это не текущий язык' do
    visit '/en'
    click_link 'RU'

    current_path.should == '/ru'
  end
  
  scenario 'Я пытаюсь поменять язык на неподдерживаемый, переход на первый поддерживаемый или дефолтный' do
    visit '/zz'
    
    current_path.should_not == '/zz'
    current_path.should == "/#{I18n.locale}"
  end
end
