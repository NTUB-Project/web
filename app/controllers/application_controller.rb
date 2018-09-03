class ApplicationController < ActionController::Base
  include CartsHelper

  def find_cart
     @current_cart ||= load_cart
  end

  private

  def load_cart
    session[User::SessionKey] = current_cart.serialize
  end

end
