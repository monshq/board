# encoding: UTF-8

def add_item
    @user = FactoryGirl.create(:user)
    sign_in_user(@user)

    visit dashboard_items_path
    click_link(I18n.t(:new_item))

    @item = FactoryGirl.attributes_for :item
    @tags = ['Электроника', 'Компьютеры']

    fill_in 'item_description',  with: @item[:description]
    fill_in 'tags',              with: @tags.join(', ')
    fill_in 'item_contact_info', with: @item[:contact_info]
    click_button I18n.t('helpers.submit.item.create')
end
