# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы иметь больше шансов продать товар, мне нужна обратная связь с покупателями - возможность переписки' do
  background do
    @user = FactoryGirl.create(:user)

    @item = FactoryGirl.create(:item, seller: @user)

    @sender = FactoryGirl.create(:user)

    message = FactoryGirl.build(:message)
    message.post(sender: @sender, recipient: @user, item: @item)

    sign_in_user(@user)

    visit dashboard_items_path
  end

  scenario 'Я нажимаю на ссылку Сообщения и вижу список сообщений' do
    click_link I18n.t(:messages)
    page.should have_text @user.received_messages[0].text
  end

  scenario 'На странице сообщений я нажимаю на ссылку Просмотр сообщения и вижу сообщение и форму для ввода ответа' do
    click_link I18n.t(:messages)
    click_link I18n.t(:view_message)

    page.should have_text @user.received_messages[0].text
    page.should have_field "Response"
  end

end

feature 'Чтобы ответить на вопрос покупателя как можно скорее, я хочу получать уведомления по email и SMS'
