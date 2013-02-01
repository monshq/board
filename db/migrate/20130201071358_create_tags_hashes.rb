class CreateTagsHashes < ActiveRecord::Migration
  def change
    create_table :tags_hashes do |t|
      t.references :item
      t.string :tags_hash
      t.integer :relevance

      t.timestamps
    end
    add_index :tags_hashes, :item_id
    add_index :tags_hashes, :tags_hash
  end
end
