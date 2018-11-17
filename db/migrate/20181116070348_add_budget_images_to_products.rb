class AddBudgetImagesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :budget_images, :json
  end
end
