class GroundsController < ApplicationController

  def index
    ground = Product.where(category: Category.find_by(title: "場地").id).group("name").select("MIN(id) AS id , name")
    grounds = []
    if ground != []
      0.upto(ground.to_a.count-1) do |i|
        grounds <<  Product.find(ground[i].id)
      end
    end
    @grounds = grounds.paginate(page: params[:page], per_page: 10)

    @search = grounds.count
    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all

  end

  def search
    all = Product.where(category: Category.find_by(title: "場地").id)
    find = all.group("name").select("MIN(id) AS id , name")
    #region
    region = find.where(region: params[:region_ids]).to_a
    region_name = []
    region.map {|i| region_name << i.name}
    #activity_kind
    activity_kind = find.where(activity_kind_id: params[:activity_kind_ids]).to_a
    activity_kind_name = []
    activity_kind.map {|i| activity_kind_name << i.name}
    #people_number
    people_number = []
    if params[:people_number_ids] != nil
      1.upto(params[:people_number_ids].max.to_i) do |i|
        if find.where(people_number: i ).to_a != []
          find.where(people_number: i ).to_a.map {|m| people_number <<  m }
        end
      end
    end
    people_number_name = []
    people_number.map{|i| people_number_name << i.name}

    #budget
    price=[]
      @price =[]
      peo = params[:people].to_i
      hou = params[:hours].to_i
      peo = 1 if peo == 0
      hou = 1 if hou == 0
      find.map{|i|
        case Product.find(i.id).budget_option

        when "按時段收費"
          @price <<  (Product.find(i.id).min_price * hou).to_s + "," + i.id.to_s

        when "三小時/一小時(續)/一天"
          if params[:hours].to_i >= 3 && Product.find(i.id).budget.blank? == false
            @price << (Product.find(i.id).budget.split(",")[0].to_i + (hou-3 ) * Product.find(i.id).budget.split(",")[1].to_i).to_s + "," + i.id.to_s
          else
            @price << Product.find(i.id).budget.split(",")[0] + "," + i.id.to_s if Product.find(i.id).budget.blank? == false
          end

        when "每小時/每人"
          @price << (Product.find(i.id).budget.to_i * peo * hou).to_s + "," + i.id.to_s
        end
      }
      1.upto(@price.count) do |i|
        index = 0
        while index < @price.count-1
          if @price[index].split(",")[0].to_i > @price[index+1].split(",")[0].to_i
            x = @price[index]
            y = @price[index+1]
            @price[index] = y
            @price[index+1] = x
          end
          index = index +1
        end
      end
      if params[:budget].blank? != true || params[:hours].blank? != true || params[:people].blank? != true
        @price.each do |i|
          if params[:budget].blank? != true
            price << Product.find(i.split(",")[1].to_i).name if i.split(",")[0].to_i <= params[:budget].to_i
          else
            price << Product.find(i.split(",")[1].to_i).name
          end
        end
      end
    #search
    product = [region_name,activity_kind_name,people_number_name,price].reject(&:empty?).reduce(:&) || []
    @grounds = []
    @price_grounds = []
    if product != []
      g_id = []
      p_id = []
      Product.where(name: product).group("name").select("MIN(id) AS id , name").map{ |i| g_id << i.id }
      @price.map{ |i| p_id << i.split(",")[1].to_i }
      ( p_id & g_id ).map{ |i| @grounds << Product.find(i) }
      ( g_id - p_id ).map{ |i| @price_grounds << Product.find(i) }

      @search = (@grounds + @price_grounds).count
      @grounds = (@grounds + @price_grounds).paginate(page: params[:page], per_page: 10)
    else
      redirect_to grounds_path, notice: "無搜尋到此條件"
    end
    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all
    @r = Region.where(id: params[:region_ids]).to_a if region != []
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a if people_number != []
    @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a if activity_kind != []
  end

  def show
    gmap = Gmap.where(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(gmap) do |hash, marker|
      marker.lat hash.latitude
      marker.lng hash.longitude
      marker.infowindow hash.product.name
    end
    @grounds = Product.where(id: params[:id])
    @product_id = Product.find(params[:id])
    @comments = @product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)
    @comment = @product_id.comments
    el = 0
    sum = 0
    @comment.each do |i|
      el = i.rating if i.rating != nil
      sum = sum + el
      @avg_rating =  sum / @comment.count
    end
    @imgs =  @product_id.images.count


  end

end
