class Matter < ApplicationRecord
  belongs_to :user
  belongs_to :product
  mount_uploaders :images, ImageUploader
  validates_presence_of :email, :mattertext
end
