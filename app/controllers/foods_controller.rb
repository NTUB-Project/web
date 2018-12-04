class FoodsController < ApplicationController

  def index
    food = Product.where(category: Category.find_by(title: "食物").id).group("name").select("MIN(id) AS id , name")
    foods = []
    if food != []
      0.upto(food.to_a.count-1) do |i|
        foods <<  Product.find_by(id: food[i].id)
      end
    end
    @foods = foods.paginate(page: params[:page], per_page: 10)
    @search = foods.count
    #checkbox
    @regions =Region.all
    @people_numbers = PeopleNumber.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "食物").id)
    find = all.group("name").select("MIN(id) AS id , name")
    #region
    region = find.where(region: params[:region_ids]).to_a
    region_name = []
    region.map {|i| region_name << i.name}
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
    #search
    product = [region_name,people_number_name].reject(&:empty?).reduce(:&) || []
    foods = []
    if product != []
      Product.where(name: product).group("name").select("MIN(id) AS id , name").map{ |i|
        foods <<  Product.find(i.id)
      }
      @search = foods.count
      @foods = foods.paginate(page: params[:page], per_page: 10)
    else
      redirect_to foods_path, notice: "無搜尋到此條件"
    end

    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @r = Region.where(id: params[:region_ids]).to_a
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a
  end

  def show
    gmap = Gmap.where(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(gmap) do |hash, marker|
      marker.lat hash.latitude
      marker.lng hash.longitude
      marker.infowindow hash.product.name
    end
    @foods = Product.where(id: params[:id])
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
