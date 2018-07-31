module CartsHelper
    def current_cart
      @cart ||= Cart.from_hash(session[current_user.id])
    end
end
