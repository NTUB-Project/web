class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    session[:cart10446] = current_cart.serialize

    redirect_to foods_path, notice: "已加入蒐藏"
    end

    def destroy
      session[:cart10446] = nil
      redirect_to foods_path, notice: "購物車已清空"
    end
end
