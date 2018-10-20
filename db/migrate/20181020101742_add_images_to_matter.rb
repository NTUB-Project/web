class AddImagesToMatter < ActiveRecord::Migration[5.2]
  def change
    add_column :matters, :images, :json
  end
end
