class CartsController < ApplicationController

before_action :current_cart

  def show
    @items = CartItem.where(:user_id => @user_id)
    @grounds = Array.new
    @foods = Array.new
    @rentcars = Array.new
    @equipments = Array.new
    @custommade = Array.new
    @costumes = Array.new
    @items.each do |item|
      @category = Product.find_by(id: item.product_id).category_id
      case @category
      when 1
        @grounds << item
      when 2
        @foods << item
      when 3
        @rentcars << item
      when 4
        @equipments << item
      when 5
        @custommade << item
      when 6
        @costumes << item
      end
    end
  end

  def add

    quantity  = CartItem.where(:cart_id => @cart_id).count
    find_item = CartItem.where(:user_id => @user_id, :product_id => params[:id])
    category = Product.find_by(id: params[:id]).category_id

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
    @matter = Array.new(params[:item_id])
  end

  def matter_send
    item_id = params.keys[2].split('/')[3].split('%2F')
    @matter = Matter.new(mattertext: params.values[2][:mattertext])
    if @matter.save
      for id in item_id
        @products = Product.find_by(id: id.to_i)
        CartMailer.say_hello_to(@matter,@products).deliver_now
      end
      redirect_to "/cart" ,notice: "已成功寄出信件!"
    else
      redirect_to "/cart" ,notice: "失敗!"
    end
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
