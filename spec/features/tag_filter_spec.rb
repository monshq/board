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

    page.should     have_text 'Продаются котята'
    page.should_not have_text 'Продаётся кактус'
  end

  scenario 'Нажав на несколько категорий, я вижу только объявления из обеих категорий' do
    FactoryGirl.create(:item, description: 'Продаются котята').set_tags 'Животные'
    FactoryGirl.create(:item, description: 'Продаётся кактус').set_tags 'Растения'
    FactoryGirl.create(:item, description: 'Продаётся террариум со змеями').set_tags 'Растения, Животные'

    visit tags_path
    click_link 'Животные'
    click_link 'Растения'

    page.should     have_text 'Продаётся террариум со змеями'
    page.should_not have_text 'Продаются котята'
    page.should_not have_text 'Продаётся кактус'
  end

  scenario 'Повторное нажатие на категорию отменяет её выбор' do
    FactoryGirl.create(:item, description: 'Продаются котята').set_tags 'Животные'
    FactoryGirl.create(:item, description: 'Продаётся кактус').set_tags 'Растения'
    FactoryGirl.create(:item, description: 'Продаётся террариум со змеями').set_tags 'Растения, Животные'

    visit tags_path
    click_link 'Животные'
    click_link 'Растения'
    click_link 'Животные'

    page.should     have_text 'Продаётся кактус'
    page.should     have_text 'Продаётся террариум со змеями'
    page.should_not have_text 'Продаются котята'
  end

  scenario 'Изменение item.contact_info не влияет на количество выбранных тэгов' do
    user = FactoryGirl.create :user
    sign_in_user user

    item = FactoryGirl.create(:item, description: 'Продаются котята', seller: user)
    item.set_tags 'Животные'

    visit tags_path
    click_link 'Животные'
    page.should     have_selector('#tagged_items .item', count: 1)

    visit edit_dashboard_item_path(item)
    fill_in 'Контактная информация', with: 'contact_info_long_enough'
    click_button I18n.t('helpers.submit.item.update')

    visit tags_path
    click_link 'Животные'
    page.should     have_selector('#tagged_items .item', count: 1)
  end

  scenario 'Теги можно удалять из объявления' do
    item = FactoryGirl.create(:item)
    item.set_tags 'Animal'
    item.set_tags 'People'
    item.tags.count.should eq 1
    item.tags.first.name.should eq 'People'
  end
end
