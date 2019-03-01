class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.float :sales
      t.float :discount
      t.integer :ship_mode_id
      t.float :profit
      t.float :shipping_cost
      t.date :ship_date
      t.integer :province_id

      t.timestamps
    end
  end
end
