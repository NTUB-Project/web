class Product < ApplicationRecord
  belongs_to :category
  belongs_to :region
  belongs_to :activity_kind
  belongs_to :people_number
  mount_uploader :image, ImageUploader
end
