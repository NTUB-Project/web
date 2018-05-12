class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :introduction
      t.string :location

      t.timestamps
    end
  end
end
