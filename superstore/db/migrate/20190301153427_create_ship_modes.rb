class CreateShipModes < ActiveRecord::Migration[5.2]
  def change
    create_table :ship_modes do |t|
      t.string :name

      t.timestamps
    end
  end
end
