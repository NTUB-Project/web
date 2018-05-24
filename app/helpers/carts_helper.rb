module CartsHelper
  def current_cart
     @cart ||= Cart.from_hash(session[:cart10446])
   end
 end
