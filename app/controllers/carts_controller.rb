class CartsController < ApplicationController

    def add
      current_cart.add_item(params[:id])
      session[:cart9487] = current_cart.serialize
    end

    def remove
      current_cart.delete_item(params[:id])
      session[:cart9487] = current_cart.serialize
      redirect_to "/cart"
    end




end
