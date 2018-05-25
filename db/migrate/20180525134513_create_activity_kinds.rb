class CreateActivityKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_kinds do |t|
      t.string :title

      t.timestamps
    end
  end
end
