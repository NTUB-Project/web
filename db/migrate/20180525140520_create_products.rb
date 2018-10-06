class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :item
      t.text :limit
      t.text :activity
      t.string :location
      t.string :tel
      t.string :email
      t.string :url
      t.text :equipment
      t.references :category
      t.references :region
      t.references :activity_kind
      t.references :people_number

      t.timestamps
    end
  end
end
