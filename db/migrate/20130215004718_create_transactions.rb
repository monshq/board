class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, :null => false
      t.references :item, :null => false
      t.float :amount, :null => false
      t.string :status, :null => false
      t.integer :tries, :default => 10, :null => false
      t.string :charge_id, :null => true

      t.timestamps
    end
    add_index :transactions, :user_id
    add_index :transactions, :item_id
  end
end
