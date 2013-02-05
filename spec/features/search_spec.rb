# encoding: UTF-8

require 'spec_helper'

feature 'Чтобы лучше указать что мне нужно, я хочу воспользоваться формой поиска' do
  background do
    FactoryGirl.create :item, description: 'Продаётся велосипед'
    FactoryGirl.create :item, description: 'Продаётся телевизор'

    visit root_path
  end

  scenario 'Я ввожу слово в поле поиска и вижу только объявления с этим словом' do
    fill_in I18n.t('find'), with: 'велосипед'
    click_button I18n.t('search')

    current_path.should == items_path
    page.should     have_text 'Продаётся велосипед'
    page.should_not have_text 'Продаётся телевизор'
  end

  scenario 'Я ничего не ввожу в поле поиска и вижу все объявления' do
    click_button I18n.t('search')

    current_path.should == items_path
    page.should have_text 'Продаётся велосипед'
    page.should have_text 'Продаётся телевизор'
  end
end
