class CreateJoinTableRoleUser < ActiveRecord::Migration[7.1]
  def change
    create_table :roles_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :role
    end

    add_index :roles_users, [:user_id, :role_id], unique: true
  end
end
