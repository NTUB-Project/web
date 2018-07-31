module CartsHelper
<<<<<<< HEAD
  def current_cart
    @cart ||= Cart.from_hash(session[User::SessionKey])
  end
=======
    def current_cart
      @cart ||= Cart.from_hash(session[current_user.id])
    end
>>>>>>> bb0dd4bb681ef3475f0364927b9411f931f81c2e
end
