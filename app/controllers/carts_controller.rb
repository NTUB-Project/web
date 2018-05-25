class CartsController < ApplicationController
    def add
      current_cart.add_item(params[:id])
      session[:cart9487] = current_cart.serialize
    end
    
    def destroy
      session[:cart9487] = nil
      redirect_to cart_path, notice: "購物車已清空"
    end
end
