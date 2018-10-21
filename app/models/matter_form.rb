class MatterForm < ApplicationRecord
  belongs_to :user
  belongs_to :product
  mount_uploaders :images, ImageUploader
  attr_accessor :skip_food, :skip_people, :skip_location, :skip_device, :skip_costommade
  validates_presence_of :email, :school, :date, :memo
  validate :people, unless: :skip_people
  validate :activity_location, unless: :skip_location
  validate :vegetarian, :non_vegetarian, :expect_menu, :budget, unless: :skip_food
  validate :device , unless: :skip_device
  validate :material, :size, unless: :skip_costommade


  def people
    errors[:people]<< "人數 未填寫或格式錯誤" unless people?
  end

  def vegetarian
    errors[:vegetarian]<< "葷食人數 未填寫或格式錯誤" unless vegetarian?
  end

  def non_vegetarian
    errors[:non_vegetarian]<< "素食人數 未填寫或格式錯誤" unless non_vegetarian?
  end

  def expect_menu
    errors[:expect_menu]<< "必要菜色 未填寫或格式錯誤" unless expect_menu?
  end

  def budget
    errors[:budget]<< "預算 未填寫或格式錯誤" unless budget?
  end

  def activity_location
    errors[:activity_location]<< "活動地點 未必填或格式錯誤" unless activity_location?
  end

  def device
    errors[:device]<< "需要的設備 未填寫或格式錯誤" unless device?
  end

  def material
    errors[:material]<< "種類/材質 未填寫或格式錯誤" unless material?
  end

  def size
    errors[:size]<< "件數 未填寫或格式錯誤" unless size?
  end

end
