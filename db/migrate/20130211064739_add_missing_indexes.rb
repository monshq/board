class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :items, :seller_id
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, :item_id
    add_index :photos, :item_id
  end
end
