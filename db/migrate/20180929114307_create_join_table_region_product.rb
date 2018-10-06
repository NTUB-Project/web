class CreateJoinTableRegionProduct < ActiveRecord::Migration[5.2]
  def change
    create_join_table :regions, :products do |t|
      # t.index [:region_id, :product_id]
      # t.index [:product_id, :region_id]
    end
  end
end
