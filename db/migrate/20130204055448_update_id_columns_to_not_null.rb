class UpdateIdColumnsToNotNull < ActiveRecord::Migration
  def up
    change_column :items, :seller_id, :integer, null: false

    change_column :items_tags, :item_id, :integer, null: false
    change_column :items_tags, :tag_id, :integer, null: false

    change_column :messages, :sender_id, :integer, null: false
    change_column :messages, :recipient_id, :integer, null: false
    change_column :messages, :item_id, :integer, null: false

    change_column :photos, :item_id, :integer, null: false
  end

  def down
    change_column :items, :seller_id, :integer, null: true

    change_column :items_tags, :item_id, :integer, null: true
    change_column :items_tags, :tag_id, :integer, null: true

    change_column :messages, :sender_id, :integer, null: true
    change_column :messages, :recipient_id, :integer, null: true
    change_column :messages, :item_id, :integer, null: true

    change_column :photos, :item_id, :integer, null: true
  end
end
