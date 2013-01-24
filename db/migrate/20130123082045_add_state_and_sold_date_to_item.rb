class AddStateAndSoldDateToItem < ActiveRecord::Migration
  def change
    add_column :items, :state, :string
    add_column :items, :sold_at, :datetime
  end
end

