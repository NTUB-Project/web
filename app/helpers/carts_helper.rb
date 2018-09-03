module CartsHelper

  def current_cart
    @current_cart ||= Cart.from_hash(session[User::SessionKey])
  end



end
