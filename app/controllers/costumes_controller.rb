class CostumesController < ApplicationController
  def index
    costume = Product.where(category: Category.find_by(title: "舞台服").id).group("name").select("MIN(id) AS id , name")
    @costumes = []
    if costume != []
      0.upto(costume.to_a.count-1) do |i|
        @costumes <<  Product.find_by(id: costume[i].id)
      end
    end
    @search = @costumes.count
    #checkbox
    @people_numbers = PeopleNumber.all
    @regions =Region.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "舞台服").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]))
    costume = find.group("name").select("MIN(id) AS id , name")
    if costume != []
      @costumes = []
      0.upto(costume.to_a.count-1) do |i|
        @costumes <<  Product.find_by(id: costume[i].id)
      end
    else
      redirect_to costumes_path, notice: "無搜尋到此條件"
    end
    @search = @costumes.count
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
    @costumes = Product.where(id: params[:id])
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

  end

end
