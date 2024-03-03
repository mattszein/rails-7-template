class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :status, default: 0
      t.references :created, null: true, foreign_key: {to_table: :users}
      t.references :assigned, null: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
