class AddImagesToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :images, :json
  end
end
