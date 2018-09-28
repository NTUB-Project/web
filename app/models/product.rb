class Product < ApplicationRecord
  belongs_to :category
  belongs_to :region
  belongs_to :activity_kind
  belongs_to :people_number
  has_many :comments
  mount_uploader :image, ImageUploader
  has_many :regions
  
end
