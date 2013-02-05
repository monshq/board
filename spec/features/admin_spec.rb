# encoding: UTF-8

require 'spec_helper'

# Администратор

feature 'Чтобы ресурс оставался популярным, я хочу постмодерировать объявления и фотографии с возможностью удалить объявление и/или забанить продавца'
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
