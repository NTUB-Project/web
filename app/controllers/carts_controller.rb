class CartsController < ApplicationController
before_action :authenticate_user!
before_action :authenticate_admin
before_action :current_cart

  def show
    @items = CartItem.where(user_id: current_user.id)
    @grounds = []
    @foods = []
    @rentcars = []
    @equipments = []
    @custommade = []
    @costumes = []
    @items.each do |item|
      if item.product == nil
        item.destroy
      else
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
  end

  def add
    if user_signed_in?
      @category = Product.find(params[:id]).category_id
      count = 0
      items = CartItem.where(user_id: current_user.id)
      items.each do |i|
        if Product.find_by(id: i.product_id) == nil
          i.destroy
        else
          count = count + 1 if @category == Product.find_by(id: i.product_id).category_id
        end
      end
      find_item = CartItem.where(user_id: current_user.id, product_id: params[:id])
      if find_item.blank? && count < 5
        CartItem.create(user_id: current_user.id , cart_id: current_cart , product_id: params[:id])
      else
        redirect_to root_path ,notice: "此類別的蒐藏已滿囉!" if find_item.blank?
      end

    else
      redirect_to new_user_session_url, notice:"請先登入再蒐藏!"
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
    if user_signed_in?
      current_cart = Cart.find_by(user_id: current_user.id )
      current_cart = Cart.create(user_id: current_user.id) if current_cart.blank?
      cart_id = current_cart[:id]
    else
      redirect_to new_user_session_url, notice:"請先登入再蒐藏!"
    end

  end

end
