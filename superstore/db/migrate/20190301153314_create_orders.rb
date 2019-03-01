class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.string :priority
      t.integer :customer_id

      t.timestamps
    end
  end
end
