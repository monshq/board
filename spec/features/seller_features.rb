# encoding: UTF-8

require 'spec_helper'

# Продавец

def sign_in_user(user)
    visit root_path
    click_link 'Войти'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    page.should have_text 'Вы успешно вошли в свою панель управления.'
end

feature 'Чтобы управлять своими объявлениями, я регистрируюсь на сайте'

feature 'Чтобы продать что либо, я подаю объявление с описанием товара и контактными данными' do
  background do
    @user = FactoryGirl.create :user
    sign_in_user @user
  end

  scenario 'Я нажимаю на ссылку "Новое объявление", заполняю форму создания объявления, и вижу его в списке' do
    visit dashboard_items_path
    click_link 'Новое объявление'

    @item = FactoryGirl.attributes_for :item
    @tags = ['Электроника', 'Компьютеры']

    fill_in 'Текст объявления',      with: @item[:description]
    fill_in 'Категории',             with: @tags.join(', ')
    fill_in 'Контактная информация', with: @item[:contact_info]
    click_button 'Подать это объявление'

    page.should have_text 'Объявление успешно размещено.'
    page.should have_text @item[:description]
    @tags.each {|t| page.should have_text t}
    page.should have_text @item[:contact_info]
  end
end

feature 'Чтобы меня не беспокоили после продажи, я хочу возможность снять товар с продажи'
feature 'Чтобы лучше представить товар, я хочу загружать несколько фотографий'
feature 'Чтобы мой товар выделялся в списках, я хочу выбрать заглавную фотографию'
feature 'Чтобы покупателю было проще найти мой товар, я хочу указать теги категорий, которым он принадлежит'
feature 'Чтобы иметь больше шансов продать товар, мне нужна обратная связь с покупателями - возможность переписки'
feature 'Чтобы ответить на вопрос покупателя как можно скорее, я хочу получать уведомления по email и SMS'
