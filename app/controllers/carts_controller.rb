class CartsController < ApplicationController

  def add
    current_cart.add_item(params[:id])
    session[User::SessionKey] = current_cart.serialize
  end


  def destroy
    session[User::SessionKey] = current_cart.serialize
    redirect_to cart_path, notice: "蒐藏已全部清空"

  end

  def remove
    current_cart.delete_item(params[:id])
    session[User::SessionKey] = current_cart.serialize
    redirect_to "/cart"
  end


end
