class CreateSegments < ActiveRecord::Migration[5.2]
  def change
    create_table :segments do |t|
      t.string :name

      t.timestamps
    end
  end
end
