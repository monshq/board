class RenameItemUserIdToItemSellerId < ActiveRecord::Migration
  def change
    rename_column :items, :user_id, :seller_id
  end
end
