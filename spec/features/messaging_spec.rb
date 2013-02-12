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
    page.should have_text @user.received_messages.first.text
  end

  scenario 'На странице сообщений я вижу поле для ввода ответа, я пишу ответ и нажимаю на Ответить' do
    click_link I18n.t(:messages)
    fill_in "new_message_text_#{@item.id.to_s}_#{@sender.id.to_s}", with: 'Мой ответ на входящее сообщение ...'
    click_button I18n.t('helpers.submit.message.create')

    page.should have_text I18n.t(:reply_sent)
    page.should_not have_text @user.received_messages.first.text
  end

  scenario 'На странице сообщений я вижу поле для ввода ответа, я не пишу ответ и нажимаю на Ответить' do
    click_link I18n.t(:messages)
    click_button I18n.t('helpers.submit.message.create')

    page.should have_text I18n.t('activerecord.errors.models.message.attributes.text.too_short')
    page.should have_text @user.received_messages.first.text
  end

  scenario 'На странице сообщений я вижу сообщения от разных пользователей' do
    sender2 = FactoryGirl.create(:user)
    5.times do |i|
      message = FactoryGirl.build(:message)
      if i.even?
        sender = @sender
      else
        sender = sender2
      end
      message.post(sender: sender, recipient: @user, item: @item)
    end

    click_link I18n.t(:messages)
    page.should have_text @sender.email
    page.should have_text sender2.email
  end

end


feature 'Чтобы ответить на вопрос покупателя как можно скорее, я хочу получать уведомления по email и SMS'

#Покупатель

feature 'Чтобы отправить сообщение продавцу' do
  background do
    @user = FactoryGirl.create(:user)
    sign_in_user(@user)
  end

  scenario 'я хочу нажать связаться и заполнить сообщение' do
    item = FactoryGirl.create(:item)
    visit item_path(item)
    click_link I18n.t(:write_message)
    fill_in :message_text, with: 'message'
    click_button I18n.t('helpers.submit.message.create')
    item.messages.count.should eq 1
    page.should have_content I18n.t(:new_message_sent)
  end
end
