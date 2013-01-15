class AddContactInfoToItems < ActiveRecord::Migration
  def change
    add_column :items, :contact_info, :string
  end
end
