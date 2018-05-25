class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :location
      t.string :tel
      t.string :email
      t.references :category
      t.references :region
      t.references :activity_kind
      t.references :people_number

      t.timestamps
    end
  end
end
