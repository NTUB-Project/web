class CreateMatters < ActiveRecord::Migration[5.2]
  def change
    create_table :matters do |t|
      t.text :mattertext
      t.integer :product_id
      t.integer :user_id
      t.timestamps
    end
  end
end
