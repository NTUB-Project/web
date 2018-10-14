class EquipmentsController < ApplicationController

  def index
    equipment = Product.where(category: Category.find_by(title: "設備").id).group("name").select("MIN(id) AS id , name")
    @equipments = []
    if equipment != []
      0.upto(equipment.to_a.count-1) do |i|
        @equipments <<  Product.find_by(id: equipment[i].id)
      end
    end
    #checkbox
    @regions =Region.all
    @activity_kinds = ActivityKind.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "設備").id)
    find = all.group("name").select("MIN(id) AS id , name")

    region = find.where(region: params[:region_ids]).to_a
    region_name = []
    region.map {|i| region_name << i.name}

    activity_kind = find.where(activity_kind_id: params[:activity_kind_ids]).to_a
    activity_kind_name = []
    activity_kind.map {|i| activity_kind_name << i.name}

    product = [region_name,activity_kind_name].reject(&:empty?).reduce(:&) || []

    if product != []
      @equipments = []
      0.upto(product.count-1) do |i|
        @equipments <<  Product.find_by(name: product[i])
      end
    else
      redirect_to equipments_path, notice: "無搜尋到此條件"
    end
    
    #checkbox
    @regions = Region.all
    @activity_kinds = PeopleNumber.all
    @r = Region.where(id: params[:region_ids]).to_a
    @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a
  end

  def show
    gmap = Gmap.where(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(gmap) do |hash, marker|
      marker.lat hash.latitude
      marker.lng hash.longitude
      marker.infowindow hash.product.name
    end
    @equipments = Product.where(id: params[:id])
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
