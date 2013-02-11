# encoding: UTF-8

require 'spec_helper'

# Администратор

feature 'Чтобы эффективно решать проблемы пользователей, я хочу уметь залогиниться под любым пользователем' do
  background do
    @USERS_LIST_SIZE = 10

    @user = FactoryGirl.create :user
    @user.grant :admin

    sign_in_user @user
  end

  scenario 'Я захожу на страницу со списком пользователей и вижу ссылку "Become user"' do
    users = FactoryGirl.create_list(:user, @USERS_LIST_SIZE)
    visit users_path

    page.should have_link 'Become user'
  end

  scenario 'Если пользователь админ, то я не вижу ссылку "Become user"' do
    visit users_path

    page.should_not have_link 'Become user'
  end

  scenario 'Я нажимаю на ссылку и становлюсь выбранным пользователем' do
    test_user = FactoryGirl.create :user

    become_user(test_user)

    page.should have_link test_user.email
  end

  scenario 'Я могу выйти из пользователя и снова стать администатором' do
    test_user = FactoryGirl.create :user

    become_user(test_user)

    click_link 'Выйти'
    page.should have_link @user.email
  end
end

feature 'Чтобы ресурс оставался популярным, я хочу постмодерировать объявления и фотографии с возможностью удалить объявление и/или забанить продавца', focus: true  do
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

  scenario 'Я захожу на страницу объявлений и вижу ссылку "Ban photo"' do
    item = FactoryGirl.create :published_item
    attach_photos_to_item(item)

    sign_in_user @user

    visit items_path

    page.should have_link 'Ban photo'
  end
end
