class GroundsController < ApplicationController

  def index
    ground = Product.where(category: Category.find_by(title: "場地").id).group("name").select("MIN(id) AS id , name")
    @grounds = []
    if ground != []
      0.upto(ground.to_a.count-1) do |i|
        @grounds <<  Product.find(ground[i].id)
      end
    end
    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @activity_kinds = ActivityKind.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "場地").id)
    find = all.group("name").select("MIN(id) AS id , name")

    region = find.where(region: params[:region_ids]).to_a

    activity_kind = find.where(activity_kind_id: params[:activity_kind_ids]).to_a

    #people_number
    people_number = []
    if params[:people_number_ids] != nil
      1.upto(params[:people_number_ids].max.to_i) do |i|
        if find.where(people_number: i ).to_a != []
          find.where(people_number: i ).to_a.map {|m|
              people_number <<  m
          }
        end
      end
    end
    product = [region,activity_kind,people_number].tap{|region| region.delete([]) }.reduce(:&) || []
    
    if product != []
      @grounds = []
      0.upto(product.to_a.count-1) do |i|
        @grounds <<  Product.find(product[i].id)
      end
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
    el = 0
    sum = 0
    @comments.each do |i|
      el = i.rating
      sum = sum + el
      @avg_rating =  sum / @comments.count
    end
  end

end
