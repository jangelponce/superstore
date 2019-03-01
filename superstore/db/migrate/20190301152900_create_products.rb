class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :unit_price
      t.integer :category_id
      t.integer :container_id
      t.float :base_margin

      t.timestamps
    end
  end
end
