class AddMessageReadState < ActiveRecord::Migration
  def change
    add_column :messages, :read_state, :string
  end
end
