class CreateAdminComments < ActiveRecord::Migration
  def change
    create_table :admin_comments do |t|
      t.string :action_type
      t.text :comment
      t.references :bannable, polymorphic: true

      t.timestamps
    end
    add_index :admin_comments, :bannable_id
  end
end
