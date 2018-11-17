class AddBudgetOptionToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :budget_option, :string
  end
end
