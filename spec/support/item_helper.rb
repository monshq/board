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

def fill_item_with(item, attributes)
  item_locale = I18n.t("activerecord.attributes.item")

  visit edit_dashboard_item_path(item)
  fill_in I18n.t(:tags), with: attributes[:tags] if attributes.has_key? :tags
  item_locale.each do |key, value|
    fill_in value, with: attributes[key] if attributes.has_key? key
  end
  find("input[type='submit']").click
end
