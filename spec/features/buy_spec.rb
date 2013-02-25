# encoding: UTF-8

require 'spec_helper'

feature "Покупка" do
  background do
    ResqueSpec.reset!
    @user = FactoryGirl.create :user
    sign_in_user @user
    
    @item = FactoryGirl.create :item, :state => 'published'
  end
  
  scenario "Данные карты не заполнены, переход на заполнение данных" do
    visit item_path(@item)
    click_link I18n.t(:buy)
    current_path.should == dashboard_card_index_path
    ProcessTransaction.should have_queue_size_of(0)
  end
  
  scenario "Данные карты заполнены, переход на список транзакций" do
    @user.stripe_customer_id = 'some_stripe'
    @user.save
    
    visit item_path(@item)
    click_link I18n.t(:buy)
    current_path.should == dashboard_transactions_path
    @item.reload
    @item.state.should == 'reserved'
    ProcessTransaction.should have_queue_size_of(1)
  end
  
  scenario "При отсутсвии цены у объявления получаем 404 страницу" do
    @item.price = nil
    @item.save
    visit dashboard_buying_item_path(@item)
    page.status_code.should == 404
    ProcessTransaction.should have_queue_size_of(0)
  end
end
