class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items, id: false do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :amount

    end
  end
end
