class AddModToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mod, :integer, default: 1
  end
end
