class AddStateAndStateChangedAtToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :state, :string
    add_column :photos, :state_changed_at, :datetime
  end
end
