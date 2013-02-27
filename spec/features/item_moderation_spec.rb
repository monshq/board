# encoding: UTF-8

require 'spec_helper'

feature 'Я хочу видеть список сообщений на медерацию' do
  background do
    sign_in_as_admin
    @item = FactoryGirl.create :item
    @item.publish
  end

  scenario 'Я публикую сообщение и оно появляется в списке модерации' do
    visit on_moderation_admin_items_path
    page.should have_text @item.description
  end

  scenario 'Я помечаю объявление модерированным и оно пропадает из списка' do
    visit on_moderation_admin_items_path
    click_link "Moderate"
    current_path.should eq on_moderation_admin_items_path
    page.should_not have_text @item.description
  end

  scenario 'Я баню объявление и оно пропадает из списка объявлений' do
    visit items_path
    page.should have_text @item.description

    visit on_moderation_admin_items_path
    click_link "Ban"
    test_text = Faker::Lorem.sentence
    fill_in "Comment", with: test_text
    click_button "Ban"
    current_path.should eq on_moderation_admin_items_path
    page.should_not have_text @item.description

    visit items_path
    page.should_not have_text @item.description
  end

  scenario 'Я изменяю забаненное сообщение и оно снова попадает в список модерации' do
    @item.ban
    visit on_moderation_admin_items_path
    page.should_not have_text @item.description

    sign_out
    sign_in_user @item.seller
    visit edit_dashboard_item_path(@item)
    fill_in I18n.t('activerecord.attributes.item.description'), with: Faker::Lorem.sentence
    click_button I18n.t 'helpers.submit.item.update'
    @item.reload.moderated.should eq "queued"

    sign_out
    sign_in_as_admin
    visit on_moderation_admin_items_path
    page.should have_text @item.description
  end

  scenario 'Я пытаюсь сделать бан для уже забаненного item' do
    @item.ban
    visit new_admin_item_ban_path(@item)
    click_button "Ban"
    page.should have_text "already banned"
  end
end
