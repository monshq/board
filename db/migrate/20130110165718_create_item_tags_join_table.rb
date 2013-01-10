class CreateItemTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :items_tags, id: false do |t|
      t.integer :item_id
      t.integer :tag_id
    end
  end
end
