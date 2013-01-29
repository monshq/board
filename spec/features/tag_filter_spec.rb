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
end
