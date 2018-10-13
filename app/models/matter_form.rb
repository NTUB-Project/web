class MatterForm < ApplicationRecord
  belongs_to :user
  belongs_to :product
  mount_uploaders :images, ImageUploader
end
