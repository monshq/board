# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы управлять своими объявлениями, я регистрируюсь на сайте' do
  background do
    @user = FactoryGirl.attributes_for :user
    register_user @user
  end

  scenario 'Я ввожу свои данные и получаю сообщение об активационном письме' do
    page.should have_text 'Спасибо'
    page.should have_text 'На ваш адрес электронной почты только что было отправлено письмо со ссылкой для активации вашей учётной записи. Пожалуйста, откройте это письмо и нажмите на ссылку.'
  end

  scenario 'Приложение отправляет мне активационное письмо' do
    message = ActionMailer::Base.deliveries.last

    message.to.should include @user[:email]
    message.subject.should == 'Активация вашей учётной записи на доске объявлений'
    message.body.should have_text 'Пожалуйста, нажмите на эту ссылку, чтобы подтвердить свою регистрацию на доске объявлений.'
    message.body.should have_link 'Активировать'
  end

  scenario 'Я перехожу по ссылке в активационном письме и вижу сообщение о том, что моя учётная запись активирована' do
    open_email @user[:email]
    current_email.click_link 'Активировать'

    page.should have_text 'Ваша учётная запись активирована. Вы также автоматически вошли в панель управления.'
  end

  scenario 'Я выхожу из учетной записи' do
    test_user = FactoryGirl.create :user
    sign_in_user(test_user)

    click_link 'Выйти'
    page.should have_link 'Войти'
  end
end
