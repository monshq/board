# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы иметь больше шансов продать товар, мне нужна обратная связь с покупателями - возможность переписки' do
  background do
    @user = FactoryGirl.create(:user)
    @user.items.create(FactoryGirl.attributes_for(:item))
    @user.items[0].messages.create(FactoryGirl.attributes_for(:message))
    sign_in_user(@user)

    visit dashboard_items_path
  end

  scenario 'Я нажимаю на ссылку Сообщения и вижу список сообщений', :focus => true do
    click_link I18n.t(:messages)

    page.should have_text @user.items[0].messages[0].text
    #page.should have_text @item[:description]
    #@tags.each {|t| page.should have_text t}
    #page.should have_text @item[:contact_info]
  end

end

feature 'Чтобы ответить на вопрос покупателя как можно скорее, я хочу получать уведомления по email и SMS'
