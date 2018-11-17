class AddMinPriceToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :min_price, :integer
  end
end
