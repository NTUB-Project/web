class AddProductIdToMatter < ActiveRecord::Migration[5.2]
  def change
    add_column :matters, :product_id, :integer
  end
end
