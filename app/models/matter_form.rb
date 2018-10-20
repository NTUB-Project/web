class MatterForm < ApplicationRecord
  belongs_to :user
  belongs_to :product
  mount_uploaders :images, ImageUploader
  validates_presence_of :email, :school, :data, :people, :vegetarian, :non_vegetarian, :budget, :activity_location, :device, :material, :size
end
