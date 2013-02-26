# encoding: UTF-8

require 'spec_helper'

feature "Сохранение данных карты" do
  background do
    ResqueSpec.reset!
    @user = FactoryGirl.create :user
    sign_in_user @user
    
    visit dashboard_card_index_path
  end
  
  scenario "Я верно заполняю данные карты", :js => true do
    fill_in 'card-number', with: '4242424242424242'
    fill_in 'card-cvc', with: '1234'
    fill_in 'card-expiry-month', with: 11
    fill_in 'card-expiry-year', with: 2014
    click_button I18n.t(:card_save)
    
    page.should have_text I18n.t(:card_saved)
    CreateCustomer.should have_queue_size_of(1)
  end
  
  scenario "Ошибка при вводе карты", :js => true do
    fill_in 'card-number', with: '4242424242424242'
    fill_in 'card-cvc', with: '1234'
    click_button I18n.t(:card_save)
    
    page.find(:xpath, "//div[@class='payment-errors']").has_content?('')
    CreateCustomer.should have_queue_size_of(0)
  end
end
