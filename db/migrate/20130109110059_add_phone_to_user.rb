class AddPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string, limit: 18
  end
end
