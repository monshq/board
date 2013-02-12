class AddCardTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :card_token, :string, :null => true
  end
end
