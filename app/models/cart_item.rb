class CartItem < ApplicationRecord
  belongs_to :cart ,required: false
  belongs_to :product ,required: false


end
