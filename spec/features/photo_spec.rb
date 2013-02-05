# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы лучше представить товар, я хочу загружать несколько фотографий' do
  scenario 'Я нажимаю на ссылку "Добавить изображение", указываю картинку, и вижу её на странице', js: true do
    @item = FactoryGirl.create :item
    sign_in_user @item.seller

    click_link 'Добавить изображение'

    attach_file 'Изображение 1', Rails.root.join('spec', 'support', 'test_image_1.jpg')
    attach_file 'Изображение 2', Rails.root.join('spec', 'support', 'test_image_2.jpg')
    attach_file 'Изображение 3', Rails.root.join('spec', 'support', 'test_image_3.jpg')
    click_button 'Save changes'

    current_path.should == dashboard_items_path
    page.should have_text 'Изображение успешно добавлено.'
    page.should have_css "img[src$='test_image_1.jpg']"
    page.should have_css "img[src$='test_image_2.jpg']"
    page.should have_css "img[src$='test_image_3.jpg']"

    @item.should have(3).photos
  end

  scenario 'Я нажимаю на ссылку "Редактировать изображения" и получаю список всех изображений с возможностью сделать их заглавными', js: true do
    @item = FactoryGirl.create :item
    sign_in_user @item.seller

    click_link I18n.t(:add_photo)

    attach_file 'Изображение 1', Rails.root.join('spec', 'support', 'test_image_1.jpg')
    attach_file 'Изображение 2', Rails.root.join('spec', 'support', 'test_image_2.jpg')
    attach_file 'Изображение 3', Rails.root.join('spec', 'support', 'test_image_3.jpg')
    click_button 'Save changes'

    current_path.should == dashboard_items_path
    @item.should have(3).photos

    click_link I18n.t(:edit_photos)

    page.should have_css "img[src$='test_image_1.jpg']"
    page.should have_css "img[src$='test_image_2.jpg']"
    page.should have_css "img[src$='test_image_3.jpg']"
    page.should have_css "a[href$='#{edit_dashboard_item_photo_path(@item, @item.photos[0])}']"
    page.should have_css "a[href$='#{edit_dashboard_item_photo_path(@item, @item.photos[1])}']"
    page.should have_css "a[href$='#{edit_dashboard_item_photo_path(@item, @item.photos[2])}']"
  end

end