class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  mount_uploader :image, ImageUploader
end
