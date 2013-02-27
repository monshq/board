class AddModeratedToItems < ActiveRecord::Migration
  def change
    add_column :items, :moderated, :string
  end
end
