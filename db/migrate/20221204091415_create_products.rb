class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.text :description, null: false
      t.date :production_dste, null: false
      t.date :expiry_date, null: false
      t.text :image, null: false
      t.integer :stock_quantity, null: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
