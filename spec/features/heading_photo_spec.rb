# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы мой товар выделялся в списках, я хочу выбрать заглавную фотографию' do
  scenario 'Я нажимаю на ссылку "Сделать заглавной" и фотография становится заглавной', js: true do
    @item = FactoryGirl.create :item
    sign_in_user @item.seller
    click_link I18n.t(:add_photo)

    attach_file 'Изображение 1', Rails.root.join('spec', 'support', 'test_image_1.jpg')
    click_button 'Save changes'
    current_path.should == dashboard_items_path
    @item.photos.find(&:is_main).should be_nil

    visit dashboard_item_photos_path(@item)
    click_link I18n.t(:make_main)
    @item.reload

    current_path.should == dashboard_item_photos_path(@item)
    page.should have_text I18n.t(:photo_made_main)
    @item.photos.find(&:is_main).should_not be_nil
  end

  scenario 'Я нажимаю на ссылку "Сделать заглавной", когда заглавная фотография уже есть, и эта фотография становится единственной заглавной', js: true do
    @item = FactoryGirl.create :item
    sign_in_user @item.seller
    click_link I18n.t(:add_photo)

    attach_file 'Изображение 1', Rails.root.join('spec', 'support', 'test_image_1.jpg')
    attach_file 'Изображение 2', Rails.root.join('spec', 'support', 'test_image_2.jpg')
    click_button 'Save changes'
    current_path.should == dashboard_items_path
    @item.should have(2).photos

    visit dashboard_item_photos_path(@item)
    find(:css, '.photos .image:first-child a').click
    current_path.should == dashboard_item_photos_path(@item)
    @item.reload
    
    initially_main = @item.photos.find { |p| p.is_main }
    initially_not_main = @item.photos.find { |p| !p.is_main }

    visit dashboard_item_photos_path(@item)
    find(:css, '.photos .image:first-child a').click
    @item.reload

    current_path.should == dashboard_item_photos_path(@item)
    page.should have_text I18n.t(:photo_made_main)
    initially_main.reload
    initially_not_main.reload
    initially_main.is_main.should == false
    initially_not_main.is_main.should == true
  end
end