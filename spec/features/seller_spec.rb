# encoding: UTF-8

require 'spec_helper'

# Продавец

def register_user(user)
  visit root_path
  click_link 'Зарегистрироваться'

  fill_in 'Адрес электронной почты', with: user[:email]
  fill_in 'Пароль',                  with: user[:password]
  fill_in 'Подтверждение пароля',    with: user[:password]
  click_button 'Sign up' # FIXME: Перевести
end

def sign_in_user(user)
    visit root_path
    click_link 'Войти'

    fill_in 'Адрес электронной почты', with: user.email
    fill_in 'Пароль',                  with: user.password
    click_button 'Sign in'

    page.should have_text 'Вы успешно вошли в свою панель управления.'
end

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
end

feature 'Чтобы продать что либо, я подаю объявление с описанием товара и контактными данными' do
  background do
    @user = FactoryGirl.create :user
    sign_in_user @user

    visit dashboard_items_path
    click_link 'Новое объявление'

    @item = FactoryGirl.attributes_for :item
    @tags = ['Электроника', 'Компьютеры']
  end

  scenario 'Я заполняю форму создания объявления правильно и вижу его в списке' do
    fill_in 'Текст объявления',      with: @item[:description]
    fill_in 'Категории',             with: @tags.join(', ')
    fill_in 'Контактная информация', with: @item[:contact_info]
    click_button 'Подать это объявление'

    page.should have_text 'Объявление успешно размещено.'
    page.should have_text @item[:description]
    @tags.each {|t| page.should have_text t}
    page.should have_text @item[:contact_info]
  end

  context 'Когда форма заполнена неправильно' do
    scenario 'Я не указываю контактную информацию и получаю сообщение об ошибке' do
      fill_in 'Текст объявления',      with: @item[:description]
      fill_in 'Категории',             with: @tags.join(', ')
      click_button 'Подать это объявление'

      page.should have_text 'Пожалуйста, укажите также контактную информацию.'
    end

    scenario 'Я ввожу слишком короткую контактную информацию и получаю сообщение об ошибке' do
      fill_in 'Текст объявления',      with: @item[:description]
      fill_in 'Категории',             with: @tags.join(', ')
      fill_in 'Контактная информация', with: 'ЛОЛшто'
      click_button 'Подать это объявление'

      page.should have_text 'Пожалуйста, укажите более подробную контактную информацию.'
    end

    scenario 'Я ввожу слишком длинную контактную информацию и получаю сообщение об ошибке' do
      fill_in 'Текст объявления',      with: @item[:description]
      fill_in 'Категории',             with: @tags.join(', ')
      fill_in 'Контактная информация', with: 'ЛОЛшто' * 99
      click_button 'Подать это объявление'

      page.should have_text 'Пожалуйста, укажите более короткую контактную информацию.'
    end
  end
end

feature 'Чтобы меня не беспокоили после продажи, я хочу возможность снять товар с продажи' do
  scenario 'Я нажимаю на ссылку "Удалить" рядом с ненужным объявлением и оно пропадает' do
    @item = FactoryGirl.create :item
    @user = @item.seller
    @descr = @item.description

    sign_in_user @user
    click_link 'Удалить'

    page.should have_text 'Объявление успешно удалено.'
    page.should_not have_text @descr
    page.should_not have_link 'Удалить'

    @user.should have(0).items
  end
end

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
end

feature 'Чтобы мой товар выделялся в списках, я хочу выбрать заглавную фотографию'
feature 'Чтобы покупателю было проще найти мой товар, я хочу указать теги категорий, которым он принадлежит'
feature 'Чтобы иметь больше шансов продать товар, мне нужна обратная связь с покупателями - возможность переписки'
feature 'Чтобы ответить на вопрос покупателя как можно скорее, я хочу получать уведомления по email и SMS'
