class AddRatingToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :rating, :integer, :default => 0
  end
end
