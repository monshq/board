# encoding: UTF-8

require 'spec_helper'

feature 'Чтобы определиться с нужным мне товаром, я хочу просмотривать списки по тегам' do
  scenario 'Я вижу все тэги, нажав на соответствующую ссылку на сайте' do
    FactoryGirl.create_list :tag, 7

    visit root_path
    click_link I18n.t('all_tags')

    Tag.pluck(:name).each do |tag_name|
      page.should have_link tag_name
    end
  end

  scenario 'Нажав на ссылку категории, я вижу только объявления из этой категории' do
    FactoryGirl.create(:item, description: 'Продаются котята').set_tags 'Животные'
    FactoryGirl.create(:item, description: 'Продаётся кактус').set_tags 'Растения'

    visit tags_path
    click_link 'Животные'

    page.should have_text 'Продаются котята'
    page.should_not have_text 'Продаётся кактус'
  end
end
