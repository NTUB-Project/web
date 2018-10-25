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
    product = []
    @items.map { |item|
      if item.product == nil
        item.destroy
      else
        @category = item.product.category_id
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
        product << item.product_id
      end
    }

    @product = Product.where(id: product)

    respond_to do |format|
      format.html
      format.csv { send_data @product.to_csv}
      format.xls { send_data @product.to_csv}
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
        redirect_back(fallback_location: root_path, notice: "加入蒐藏")
      else
        redirect_back(fallback_location: root_path, alert: "已蒐藏過囉！") unless find_item.blank?
        redirect_back(fallback_location: root_path, alert: "此類別的蒐藏已滿囉!")  if find_item.blank?
      end

    else
      redirect_to new_user_session_url, alert:"請先登入再蒐藏!"
    end
  end

  def remove
    cart_items = CartItem.find_by(product_id: params[:id])
    cart_items.destroy
    redirect_to "/cart", notice:"刪除成功！"
  end

  def matter
    if params[:item_id] == nil
      redirect_back(fallback_location: root_path, alert: "您還未選擇廠商！")
    else
      @product = Product.where(id: params[:item_id])
      @item_id = params[:item_id]
      @matter = Matter.new
      @category = Product.find(params[:item_id][0].to_i).category_id
    end
  end

  def matter_send
    @item_id = params.keys[1].split('/')[3].split('%2F')
    if params[:commit] == "寄出"
      if params[:Radios] == "option2"
          @item_id.map{ |i|
            if params[i] == ""
              respond_to do |format|
                @errors = "分開信件內容不能為空"
                format.html { return render :matter }
                format.js {return render :matter_send }
              end
            end
          }
      end
      @item_id.map{ |i|
        @matter = current_user.matters.new(matter_params)
        @matter.mattertext = params[i] if params[:Radios] == "option2"
        @matter.product_id = i
        @matter.save
        if @matter.save
          @products = Product.find_by(id: i)
          CartMailer.matter(@matter,@products).deliver_now
          cart_items = CartItem.find_by(product_id: i)
          cart_items.destroy
        else
          respond_to do |format|
            format.html { return render :matter }
            format.js {return render :matter_send }
          end

        end
      }
      respond_to do |format|
        if @matter.save
          flash[:notice] = "已成功寄出信件，並移至「我的寄件夾」"
          format.html { redirect_to controller: "carts", action: "show"}
          format.js   { render js: "window.location.href='#{cart_path}'"}
        end
      end
    else
      @matter = current_user.matters.new(matter_params)
      @matter.mattertext = @item_id.map { |i| params[i] } if params[:Radios] == "option2"
      @products = Product.where(id: @item_id)
    end
  end

  def matter_form_send
    @item_id = params.keys[1].split('/')[3].split('%2F')
    if params[:commit] == "寄出"
      if params[:Radios] == "option2"
          @item_id.map{ |i|
            if params[i] == ""
              respond_to do |format|
                @errors = "分開信件內容不能為空"
                format.html { return render :matter }
                format.js {return render :matter_form_send }
              end
            end
          }
      end
      @item_id.map { |i|
        @matter_form = current_user.matter_forms.new(matter_form_params)
        @matter_form.memo = params[i] if params[:Radios] == "option2"
        @matter_form.product_id = i
        categroy = Category.find(Product.find_by(id: i).category_id).title
        case categroy
          when "場地"
            @matter_form.skip_food = true
            @matter_form.skip_location = true
            @matter_form.skip_device = true
            @matter_form.skip_costommade = true
          when "食物"
            @matter_form.skip_device = true
            @matter_form.skip_costommade = true
          when "租車"
            @matter_form.skip_food = true
            @matter_form.skip_device = true
            @matter_form.skip_costommade = true
          when "設備"
            @matter_form.skip_food = true
            @matter_form.skip_costommade = true
            @matter_form.skip_people = true
          when "印刷"
            @matter_form.skip_food = true
            @matter_form.skip_location = true
            @matter_form.skip_device = true
            @matter_form.skip_people = true
          when "舞台服"
            @matter_form.skip_food = true
            @matter_form.skip_location = true
            @matter_form.skip_device = true
            @matter_form.skip_people = true
        end
        @matter_form.save
        if @matter_form.save
          @products = Product.find_by(id: i)
          CartMailer.matter_form(@matter_form,@products).deliver_now
          cart_items = CartItem.find_by(product_id: i)
          cart_items.destroy
        else
          respond_to do |format|
            format.html { return render :matter }
            format.js {return render :matter_form_send }
          end
        end
      }
      respond_to do |format|
        if @matter_form.save
          flash[:notice] = "已成功寄出信件，並移至「我的寄件夾」"
          format.html { redirect_to controller: "carts", action: "show"}
          format.js   { render js: "window.location.href='#{cart_path}'"}
        end
      end
    else
      @matter_form = current_user.matter_forms.new(matter_form_params)
      @matter_form.memo = @item_id.map { |i| params[i] } if params[:Radios] == "option2"
      @products = Product.where(id: @item_id)
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


  def matter_form_params
  item = params.keys[1].split('/')[3]
  params.require(:"/cart/matter/#{item}").permit(:email, :school, :people, :'date(1i)', :'date(2i)', :'date(3i)', :'date(4i)', :'date(5i)', :vegetarian, :non_vegetarian, :expect_menu, :budget, :activity_location, :device, :material, :size, :memo, :images => [])
  end

  def matter_params
  item = params.keys[1].split('/')[3]
  params.require(:"/cart/matter/#{item}").permit(:email, :mattertext, :images => [])
  end


end
