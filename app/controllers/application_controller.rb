class ApplicationController < ActionController::Base
  include CartsHelper

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    unless cart.present?
      cart = Cart.create
    end
      session[:cart_id] = cart.id
      cart
  end

end
