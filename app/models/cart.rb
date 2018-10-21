class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product
  attr_accessor :skip_food, :skip_people, :skip_location, :skip_device, :skip_costommade

end
