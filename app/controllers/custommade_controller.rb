class CustommadeController < ApplicationController
  def index
    custommade = Product.where(category: Category.find_by(title: "印刷").id).group("name").select("MIN(id) AS id , name")
    custommades = []
    if custommade != []
      0.upto(custommade.to_a.count-1) do |i|
        custommades <<  Product.find_by(id: custommade[i].id)
      end
    end
    @custommades = custommades.paginate(page: params[:page], per_page: 10)
    @search = custommades.count
    #checkbox
    @regions =Region.all
  end

  def search
    all = Product.where(category: Category.find_by(title: "印刷").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]))
    custommade = find.group("name").select("MIN(id) AS id , name")
    if custommade != []
      @custommades = []
      0.upto(custommade.to_a.count-1) do |i|
        @custommades <<  Product.find_by(id: custommade[i].id)
      end
      @search = @custommades.count
    else
      redirect_to custommade_index_path, notice: "無搜尋到此條件"
    end

    #checkbox
    @regions = Region.all
    @r = Region.where(id: params[:region_ids]).to_a
  end

  def show
    gmap = Gmap.where(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(gmap) do |hash, marker|
      marker.lat hash.latitude
      marker.lng hash.longitude
      marker.infowindow hash.product.name
    end
    @custommades = Product.where(id: params[:id])
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
