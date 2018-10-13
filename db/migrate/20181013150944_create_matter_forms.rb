class CreateMatterForms < ActiveRecord::Migration[5.2]
  def change
    create_table :matter_forms do |t|
      t.string :email
      t.string :school
      t.datetime :date
      t.integer :people
      t.integer :vegetarian
      t.integer :non_vegetarian
      t.text :expect_menu
      t.integer :budget
      t.string :activity_location
      t.text :device
      t.text :material
      t.text :size
      t.json :images
      t.text :memo
      t.integer :user_id
      
      t.timestamps
    end
  end
end
