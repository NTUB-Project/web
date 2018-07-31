class CartsController < ApplicationController

    def add
      current_cart.add_item(params[:id])
<<<<<<< HEAD
      session[User::SessionKey] = current_cart.serialize
=======
      session[current_user.id] = current_cart.serialize
>>>>>>> bb0dd4bb681ef3475f0364927b9411f931f81c2e
    end

    def remove
      current_cart.delete_item(params[:id])
<<<<<<< HEAD
      session[User::SessionKey] = current_cart.serialize
      redirect_to "/cart"
    end

    def destroy
      session[User::SessionKey] = nil
      redirect_to cart_path, notice: "蒐藏已全部清空"
    end
=======
      session[current_user.id] = current_cart.serialize
      redirect_to "/cart"
    end


>>>>>>> bb0dd4bb681ef3475f0364927b9411f931f81c2e
end
