class EquipmentsController < ApplicationController

  def index
    equipment = Product.where(category: Category.find_by(title: "設備").id).group("name").select("MIN(id) AS id , name")
    equipments = []
    if equipment != []
      0.upto(equipment.to_a.count-1) do |i|
        equipments <<  Product.find_by(id: equipment[i].id)
      end
    end
    @equipments = equipments.paginate(page: params[:page], per_page: 10)
    @search = equipments.count
    #checkbox
    @regions =Region.all
    @activity_kinds = ActivityKind.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "設備").id)
    find = all.where(region: params[:region_ids]).or(all.where(activity_kind_id: params[:activity_kind_ids]))
    equipment = find.group("name").select("MIN(id) AS id , name")
    if equipment != []
      @equipments = []
      0.upto(equipment.to_a.count-1) do |i|
        @equipments <<  Product.find_by(id: equipment[i].id)
      end
      @search = @equipments.count
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
