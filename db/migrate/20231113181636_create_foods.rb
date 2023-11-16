class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement_unit
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :quantity, precision: 10, scale: 2, null: false
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
