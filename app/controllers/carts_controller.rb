class CartsController < ApplicationController
    def add
      current_cart.add_item(params[:id])
      session[:cart9487] = current_cart.serialize
    end

    def update
      current_cart.delete_item(params[:id])
      session[:cart9487] = current_cart.serialize
      redirect_to "/cart"
    end

    def destroy
      session[:cart9487] = nil
      redirect_to cart_path, notice: "蒐藏已全部清空"
    end
end
