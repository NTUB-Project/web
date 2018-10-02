class CreateMatters < ActiveRecord::Migration[5.2]
  def change
    create_table :matters do |t|
      t.text :mattertext
      t.timestamps
    end
  end
end
