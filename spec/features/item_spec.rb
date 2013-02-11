# encoding: UTF-8

require 'spec_helper'

# Продавец

feature 'Чтобы продать что либо, я подаю объявление с описанием товара и контактными данными' do
  background do
    @user = FactoryGirl.create :user
    sign_in_user @user

    visit dashboard_items_path
    click_link I18n.t(:new_item)

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
    scenario 'Я заполняю текст и тэги без контактной информации, получаю ошибку, и текст в полях остаётся' do
      fill_in 'Текст объявления',      with: @item[:description]
      fill_in 'Категории',             with: @tags.join(', ')
      click_button I18n.t 'helpers.submit.item.create'

      page.should have_content @item[:description]
      page.should have_css "input[value=\"#{@tags.join(', ')}\"]"
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

feature 'Чтобы изменить объявление' do
  background do
    add_item
    click_link I18n.t(:edit_item)
  end

  scenario 'я нажимаю на ссылку редактировать и изменяю аттрибуты правильно' do
    descr = @item[:description] + 'updated'
    tags = ['Компьютеры', 'Мониторы']
    contact_info = @item[:contact_info] + 'updated'

    fill_in 'item_description', with: descr
    fill_in 'tags',             with: tags.join(', ')
    fill_in 'item_contact_info', with: contact_info
    click_button I18n.t('helpers.submit.item.update')

    page.should have_text I18n.t(:item_updated)
    page.should have_text descr
    tags.each {|t| page.should have_text t}
    page.should have_text contact_info
  end

  context 'Когда форма редактирования заполнена неправильно' do
    scenario 'Я стираю контактную информацию и получаю сообщение об ошибке' do
      fill_in 'item_contact_info', with: ''
      click_button I18n.t('helpers.submit.item.update')

      page.should have_text 'Пожалуйста, укажите также контактную информацию.'
    end

    scenario 'Я ввожу слишком короткую контактную информацию и получаю сообщение об ошибке' do
      fill_in 'Текст объявления',      with: @item[:description]
      fill_in 'Категории',             with: @tags.join(', ')
      fill_in 'Контактная информация', with: 'ЛОЛшто'
      click_button I18n.t('helpers.submit.item.update')

      page.should have_text 'Пожалуйста, укажите более подробную контактную информацию.'
    end

    scenario 'Я ввожу слишком длинную контактную информацию и получаю сообщение об ошибке' do
      fill_in 'Текст объявления',      with: @item[:description]
      fill_in 'Категории',             with: @tags.join(', ')
      fill_in 'Контактная информация', with: 'ЛОЛшто' * 99
      click_button I18n.t('helpers.submit.item.update')
      
      page.should have_text 'Пожалуйста, укажите более короткую контактную информацию.'
    end
  end
end

feature 'Я хочу иметь возможность удалять объявления' do
  background do
    add_item
  end

  scenario 'Я нажимаю на ссылку редактировать и меняю state на Удалить после этого объявление исчезает из списка, но не из базы' do
    click_link I18n.t(:edit_item)
    select('archived', from: 'item[state]')
    click_button I18n.t('helpers.submit.item.update')

    page.should_not have_text @item[:description]
  end
  
  scenario 'После удаления объявления, связанные сущности(сообщения/фотографии) также удаляются (помечаются как archived)' do
    @item = @user.items.first
    5.times { add_message(@item, @user) }
    3.times { add_photo(@item) }

    visit edit_dashboard_item_path(@item)

    select('archived', from: 'item[state]')
    click_button I18n.t('helpers.submit.item.update')

    page.should_not have_text @item[:description]

    click_link I18n.t(:messages)
    for message in @item.messages
      page.should_not have_text message.text
    end

    visit dashboard_item_photos_path(@item)
    page.should_not have_css('img')
  end
end

feature 'Чтобы меня не беспокоили после продажи, я хочу иметь возможность снять товар с продажи' do
  scenario 'Я кликаю на ссылку редактировать, попадаю на страницу с формой редатирования и меняю статус на Продано', js: true do
    add_item
    click_link I18n.t(:edit_item)

    page.should have_text I18n.t(:edit_item)
    page.should have_field('item[description]', text: @descr)
    page.should have_select('item[state]', selected: 'hidden')

    select('sold', from: 'item[state]')
    click_button I18n.t('helpers.submit.item.update')

    page.should have_text 'sold'  #I18n.t :sold
  end
end

#Покупатель
feature 'Чтобы просмотреть опубликованные объявления' do
  background do
    states = Item.state_machine.states.map &:name
    states.each do |state|
      FactoryGirl.create(:item, state: state)
    end
  end

  scenario 'Я перехожу на страницу просмотра всех объявлений' do
    visit items_path
    page.should have_selector('.item', count: 1)
  end

  scenario 'Я могу просмотреть отдельное объявление' do
    visit items_path
    find('.show a').click
    page.status_code.should be 200
  end
end

