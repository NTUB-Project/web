class CartsController < ApplicationController

before_action :current_cart

  def show
    @items = CartItem.where(:user_id => @user_id)
  end

  def add
    quantity  = CartItem.where(:cart_id => @cart_id).count
    find_item = CartItem.where(:user_id => @user_id, :product_id => params[:id])
    if find_item.blank? && quantity < 5
      CartItem.create( :user_id => @user_id , :cart_id => @cart_id , :product_id => params[:id] )
    end
  end

  def remove
    cart_items = CartItem.find_by(product_id: params[:id])
    cart_items.destroy
    redirect_to "/cart"
  end
  
  def matter
    @items = CartItem.where(product_id: params[:item_id])
    @matter = Matter.new
    if @matter.save
      @items.each do |item|
        @a = item.product_id
        @b=Product.find_by(id: @a)
        CartMailer.say_hello_to(item,@b).deliver_now
      end
    else
      redirect_to "/cart" ,notice: "失敗!"
    end
      redirect_to "/cart" ,notice: "已成功寄出信件!"
  end

private

  def current_cart
    @user_id = User.order(current_sign_in_at: :desc).first.id
    @current_cart = Cart.find_by(user_id: @user_id )
    if @current_cart.blank?
    @current_cart = Cart.create(:user_id => @user_id)
    end
    @cart_id = @current_cart[:id]
  end
  
  
end
