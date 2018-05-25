class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :location
      t.string :tel
      t.string :email
      t.reference :category
      t.reference :region
      t.reference :activity_kind
      t.reference :people_number

      t.timestamps
    end
  end
end
