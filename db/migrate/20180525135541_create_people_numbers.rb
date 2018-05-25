class CreatePeopleNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :people_numbers do |t|
      t.string :title

      t.timestamps
    end
  end
end
