class CreateGmaps < ActiveRecord::Migration[5.2]
  def change
    create_table :gmaps do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.integer :product_id

      t.timestamps
    end
  end
end
