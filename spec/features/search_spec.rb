# encoding: UTF-8

require 'spec_helper'

feature 'Чтобы лучше указать что мне нужно, я хочу воспользоваться формой поиска' do
  background do
    FactoryGirl.create :item, description: 'Продаётся велосипед', state: 'published'
    FactoryGirl.create :item, description: 'Продаётся телевизор', state: 'published'

    sleep 10 # Let ElasticSearch update its index

    visit root_path
  end

  scenario 'Я ввожу слово в поле поиска и вижу только объявления с этим словом', js: true do
    fill_in 'keywords', with: 'велосипед'
    page.execute_script("$('form.navbar-search').submit();")

    current_path.should == items_path
    page.should     have_text 'Продаётся велосипед'
    page.should_not have_text 'Продаётся телевизор'
  end

  scenario 'Я ничего не ввожу в поле поиска и вижу все объявления', js: true do
    page.execute_script("$('form.navbar-search').submit();")

    current_path.should == items_path
    page.should have_text 'Продаётся велосипед'
    page.should have_text 'Продаётся телевизор'
  end
end
