class RenameStatusToStateForTransaction < ActiveRecord::Migration
  def change
    rename_column :transactions, :status, :state
  end
end
