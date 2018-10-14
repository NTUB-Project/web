class RentcarsController < ApplicationController

  def index
    rentcar = Product.where(category: Category.find_by(title: "租車").id).group("name").select("MIN(id) AS id , name")
    @rentcars = []
    if rentcar != []
      0.upto(rentcar.to_a.count-1) do |i|
        @rentcars <<  Product.find_by(id: rentcar[i].id)
      end
    end
    #checkbox
    @regions =Region.all
    @people_numbers = PeopleNumber.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "租車").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]))
    rentcar = find.group("name").select("MIN(id) AS id , name")
    if rentcar != []
      @rentcars = []
      0.upto(rentcar.to_a.count-1) do |i|
        @rentcars <<  Product.find_by(id: rentcar[i].id)
      end
    else
      redirect_to rentcars_path, notice: "無搜尋到此條件"
    end
    #checkbox
    @regions = Region.all
    @people_numbers = PeopleNumber.all
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
    @rentcars = Product.where(id: params[:id])
    @product_id = Product.find(params[:id])
    @comments = @product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)
    @comment = @product_id.comments
    el = 0
    sum = 0
    @comment.each do |i|
      el = i.rating
      sum = sum + el
      @avg_rating =  sum / @comment.count
    end
  end

end
