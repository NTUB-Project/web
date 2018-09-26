class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  mount_uploaders :images, ImageUploader
end
