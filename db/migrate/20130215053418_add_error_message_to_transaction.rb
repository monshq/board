class AddErrorMessageToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :error_message, :string, :null => true
  end
end
