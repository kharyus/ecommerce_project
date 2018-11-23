class CreateFoodsOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :foods_orders do |t|
      t.references :food, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
