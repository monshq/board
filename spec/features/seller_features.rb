# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы управлять своими объявлениями, я регистрируюсь на сайте'

feature 'Чтобы продать что либо, я подаю объявление с описанием товара и контактными данными' do
  background do
    @user = FactoryGirl.create :user
    login_as @user, scope: :user, run_callbacks: false
  end

  scenario 'Я вижу свои объявления' do
    d = Faker::Lorem.sentence
    @user.items.create description: d
    visit '/dashboard/items'
    page.should have_content d
  end

  after(:each) {Warden.test_reset!}
end

feature 'Чтобы меня не беспокоили после продажи, я хочу возможность снять товар с продажи'
feature 'Чтобы лучше представить товар, я хочу загружать несколько фотографий'
feature 'Чтобы мой товар выделялся в списках, я хочу выбрать заглавную фотографию'
feature 'Чтобы покупателю было проще найти мой товар, я хочу указать теги категорий, которым он принадлежит'
feature 'Чтобы иметь больше шансов продать товар, мне нужна обратная связь с покупателями - возможность переписки'
feature 'Чтобы ответить на вопрос покупателя как можно скорее, я хочу получать уведомления по email и SMS'
