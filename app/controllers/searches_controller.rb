class SearchesController < ApplicationController

  def index
    all = Product.all
    find = all.group("name").select("MIN(id) AS id , name")
    product = find.where(region: params[:region_ids]).or(
              find.where(activity_kind_id: params[:activity_kind_ids]))
    if @keywords = params[:keywords]
      keywords = find.where([ "name like ? or description like ? or item like ? or equipment like ? ", "%#{params[:keywords]}%", "%#{params[:keywords]}%", "%#{params[:keywords]}%", "%#{params[:keywords]}%" ])
    end
    people_number = []
    if params[:people_number_ids] != nil
      1.upto(params[:people_number_ids].to_i) do |i|
        people_number << find.find_by(people_number: i )
      end
    end
    product = (product + people_number + keywords).uniq
    @products = []
    if product != []
      0.upto(product.to_a.count-1) do |i|
        @products <<  Product.find(product[i].id)
      end
    else
      0.upto(find.to_a.count-1) do |i|
        @products << Product.find(find[i].id)
      end
    end

    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all
    @categories = Category.all
    @r = Region.where(id: params[:region_ids]).to_a
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a
    @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a
    @c = Category.where(id: params[:category_ids]).to_a
  end

  def search
    all = Product.all
    find = all.group("name").select("MIN(id) AS id , name")
    product = find.where(region: params[:region_ids]).or(
              find.where(category_id: params[:category_ids]).or(
              find.where(activity_kind_id: params[:activity_kind_ids])))
    if params[:people_number_ids] != nil
      people_number = []
      1.upto(params[:people_number_ids].max.to_i) do |i|
        people_number << find.find_by(people_number: i ) if find.find_by(people_number: i ) != nil
      end
    end
    product = (product + people_number).uniq
    @products = []
    if product != []
      0.upto(product.to_a.count-1) do |i|
        @products <<  Product.find(product[i].id)
      end
    else
      redirect_to searches_path, notice: "無搜尋到此條件"
    end
    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all
    @categories = Category.all
    @r = Region.where(id: params[:region_ids]).to_a
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a
    @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a
    @c = Category.where(id: params[:category_ids]).to_a
  end

  def show
    gmap = Gmap.where(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(gmap) do |hash, marker|
      marker.lat hash.latitude
      marker.lng hash.longitude
      marker.infowindow hash.product.name
    end
    @products = Product.where(id: params[:id])
    product_id = Product.find(params[:id])
    @comments = product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)
    el = 0
    sum = 0
    @comments.each do |i|
      el = i.rating
      sum = sum + el
      @avg_rating =  sum / @comments.count
    end
  end


end
