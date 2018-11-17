class AddBudgetToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :budget, :string
  end
end
