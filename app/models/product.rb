class Product < ApplicationRecord
  belongs_to :category
  belongs_to :activity_kind
  belongs_to :people_number
  belongs_to :region
  belongs_to :activity_kind
  has_many :comments
  mount_uploaders :images, ImageUploader
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :activity_kinds
end
