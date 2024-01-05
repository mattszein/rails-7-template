class AddRolesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :roles, :integer, array: true
    add_index :users, :roles, using: "gin"
  end
end
