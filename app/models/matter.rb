class Matter < ApplicationRecord
  belongs_to :user
  belongs_to :product
  mount_uploaders :images, ImageUploader
  validates :mattertext, presence: { message: "信件內容 未填寫" }
end
