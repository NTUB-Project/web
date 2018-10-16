class AddEmailToMatter < ActiveRecord::Migration[5.2]
  def change
    add_column :matters, :email, :string
  end
end
