# encoding: UTF-8

require 'spec_helper'

# Администратор

feature 'Чтобы ресурс оставался популярным, я хочу постмодерировать объявления'
feature 'Я хочу иметь возможность удалить объявление'

feature 'Администратор может забанить фотографии' do
  background do
    @user = FactoryGirl.create :user
    @user.grant :admin

    sign_in_user @user
    @photo = FactoryGirl.create :photo
    @photo.item.publish
  end

  scenario 'Я захожу на страницу объявлений и вижу ссылку "Ban photo"' do
    visit items_path
    page.should have_link 'Ban photo'
  end

  scenario 'Я нажимаю на ссылку "Ban photo" и перехожу на форму добавления комментария к бану фотографии' do
    visit items_path
    click_link 'Ban photo'

    current_path.should == new_admin_photo_ban_path(@photo)
    page.should have_button 'Create Admin comment'
  end

  scenario 'Я заполняю поле комментария и нажимаю кнопку добавления комментария к бану фотографии' do
    visit new_admin_photo_ban_path(@photo)
    fill_in 'Comment', with: Faker::Lorem.sentence
    click_button 'Create Admin comment'

    current_path.should == items_path
    page.should have_text 'Allow photo'
  end

  scenario 'После бана фотографии пользователю отправляется письмо с сообщением, в котором указывается причина бана' do
    visit new_admin_photo_ban_path(@photo)
    comment = Faker::Lorem.sentence
    fill_in 'Comment', with: comment
    click_button 'Create Admin comment'

    message = ActionMailer::Base.deliveries.last

    message.to.should include @photo.item.seller.email
    message.body.should have_text comment
    message.body.should have_link @photo.file
  end

  scenario 'Я могу разбанить забаненную фотографию' do
    @photo.ban
    visit items_path
    click_link 'Allow photo'

    current_path.should == items_path
    page.should have_link 'Ban photo'
  end
end

feature 'Администратор может забанить пользователя' do
  background do
    @user = FactoryGirl.create :user
    @user.grant :admin

    sign_in_user @user
  end

  scenario 'Я захожу на страницу со списком пользователей и вижу ссылку "Ban user"' do
    test_user = FactoryGirl.create :user

    visit users_path

    page.should have_link 'Ban user'
  end

  scenario 'Если пользователь админ, то я не вижу ссылку "Ban user"' do
    visit users_path

    page.should_not have_link 'Ban user'
  end

  scenario 'Я нажимаю на ссылку и перехожу на форму добавления комментария к бану пользователя' do
    test_user = FactoryGirl.create :user

    new_ban_user(test_user)

    current_path.should == new_admin_user_ban_path(user_id: test_user.id)
    page.should have_button 'Create Admin comment'
  end

  scenario 'Я заполняю поле комментария и нажимаю кнопку добавления комментария к бану' do
    test_user = FactoryGirl.create :user
    comment = Faker::Lorem.sentence

    ban_user(test_user, comment)

    current_path.should == users_path
    page.should have_text 'Allow user'
  end

  scenario 'После бана пользователю отправляется письмо с сообщением, в котором указывается причина бана' do
    test_user = FactoryGirl.create :user
    comment = Faker::Lorem.sentence

    ban_user(test_user, comment)

    message = ActionMailer::Base.deliveries.last

    message.to.should include test_user.email
    message.body.should have_text comment
  end

  scenario 'Я могу разбанить забаненного пользователя' do
    test_user = FactoryGirl.create :user
    comment = Faker::Lorem.sentence

    ban_user(test_user, comment)

    click_link 'Allow user'

    current_path.should == users_path
    page.should have_link 'Ban user'
  end
end

feature 'Админ может редактировать чужие объявления' do
  background do
    @user = FactoryGirl.create :user
    @user.grant :admin
    sign_in_user @user

    @item = FactoryGirl.create :published_item
  end

  scenario 'Есть ссылка "Admin edit Item" на странице со списком объявлений' do
    visit items_path
    page.should have_link 'Admin edit item'
  end

  scenario 'Я нажимаю на ссылку "Admin edit item" и перехожу на форму редактирования объявления' do
    visit items_path
    click_link 'Admin edit item'
    current_path.should == edit_admin_item_path(@item)
    page.should have_text @item.description
  end

  scenario 'Я заполняю поле описания объявления и нажимаю кнопку редактирования' do
    test_description = Faker::Lorem.sentence

    visit edit_admin_item_path(@item)
    fill_in 'Текст объявления', with: test_description
    click_button 'Сохранить изменения'

    current_path.should == items_path
    page.should have_text test_description
  end
end
