class AddStateToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :state, :string
  end
end
