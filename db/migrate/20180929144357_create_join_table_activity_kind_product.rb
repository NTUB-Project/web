class CreateJoinTableActivityKindProduct < ActiveRecord::Migration[5.2]
  def change
    create_join_table :activity_kinds, :products do |t|
      # t.index [:activity_kind_id, :product_id]
      # t.index [:product_id, :activity_kind_id]
    end
  end
end
