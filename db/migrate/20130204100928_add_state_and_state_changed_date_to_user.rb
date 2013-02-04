class AddStateAndStateChangedDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :state,            :string
    add_column :users, :state_changed_at, :datetime
  end
end
