class MatterForm < ApplicationRecord
  belongs_to :user
  belongs_to :product
  mount_uploaders :images, ImageUploader
  attr_accessor :skip_food, :skip_people, :skip_location, :skip_device, :skip_costommade
  validates :school, presence: { message: "學校 未填寫" }
  validates :date, presence: { message: "日期 未填寫" }
  validates :memo, presence: { message: "備註 未填寫" }
  validates :people, numericality: { greater_than: 0 , message: "人數 未填寫或格式錯誤"}, unless: :skip_people
  validates :activity_location, presence: { message: "活動地點 未填寫" }, unless: :skip_location
  validates :vegetarian, numericality: { greater_than_or_equal_to: 0 , message: "葷食人數 未填寫或格式錯誤"}, unless: :skip_food
  validates :non_vegetarian, numericality: { greater_than_or_equal_to: 0 , message: "素食人數 未填寫或格式錯誤"}, unless: :skip_food
  validates :expect_menu, presence: { message: "必要菜色 未填寫" }, unless: :skip_food
  validates :budget, numericality: { greater_than: 0 , message: "預算 未填寫或格式錯誤"}, unless: :skip_food
  validates :device, presence: { message: "需要的設備 未填寫" }, unless: :skip_device
  validates :material, presence: { message: "材質/種類 未填寫" }, unless: :skip_costommade
  validates :size, numericality: { greater_than: 0 , message: "件數 未填寫或格式錯誤"}, unless: :skip_costommade



end
