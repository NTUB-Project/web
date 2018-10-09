class GroundsController < ApplicationController
  def index
    find = Product.where(category: Category.find_by(title: "場地").id)
    @ground = find.group("name").select("MIN(id) AS id , name")
    @grounds = Array.new
    if @ground != []
      0.upto(@ground.to_a.count-1) do |i|
        @grounds <<  Product.find_by(id: @ground[i].id)
      end
    end
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all

  end

  def search
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all
    all = Product.where(category: Category.find_by(title: "場地").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]).or(all.where(activity_kind_id: params[:activity_kind_ids])))
    @ground = find.group("name").select("MIN(id) AS id , name")

    if @ground != []
        @grounds = Array.new
        0.upto(@ground.to_a.count-1) do |i|
          @grounds <<  Product.find_by(id: @ground[i].id)
        end
      else
        redirect_to grounds_path, notice: "無搜尋到此條件"
    end

    @r = Array.new
    @p = Array.new
    @a = Array.new
    @r = Region.where(id: params[:region_ids]).to_a
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a
    @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a


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
    el = 0
    sum = 0
    @comments.each do |i|
      el = i.rating
      sum = sum + el
      @avg_rating =  sum / @comments.count
    end

  end
end
