class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|
      t.string :resource
      t.integer :role_ids, array: true, default: [1]

      t.timestamps
      t.index :resource, unique: true
    end
  end
end
