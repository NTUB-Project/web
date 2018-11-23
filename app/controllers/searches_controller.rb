class SearchesController < ApplicationController

  def index
    all = Product.all
    find = all.group("name").select("MIN(id) AS id , name")

    region = find.where(region: params[:region_ids]).to_a
    region_name = []
    region.map {|i| region_name << i.name}

    activity_kind = find.where(activity_kind_id: params[:activity_kind_ids]).to_a
    activity_kind_name = []
    activity_kind.map {|i| activity_kind_name << i.name}

    @keywords = params[:keywords] if params[:keywords] != nil
    keyword = find.where([ "name like ? or description like ? or item like ? or equipment like ? ", "%#{params[:keywords]}%", "%#{params[:keywords]}%", "%#{params[:keywords]}%", "%#{params[:keywords]}%" ]).to_a
    keyword_name = []
    keyword.map {|i| keyword_name << i.name}

    people_number = []
    if params[:people_number_ids] != nil
      1.upto(params[:people_number_ids].to_i) do |i|
        if find.where(people_number: i ).to_a != []
          find.where(people_number: i ).to_a.map {|m| people_number <<  m }
        end
      end
    end
    people_number_name = []
    people_number.map {|i| people_number_name << i.name }

    product = [region_name,activity_kind_name,people_number_name,keyword_name].reject(&:empty?).reduce(:&) || []

    products = []
    if product != []
      0.upto(product.to_a.count-1) do |i|
        products <<  Product.find_by(name: product[i])
      end
    else
      0.upto(find.to_a.count-1) do |i|
        products <<  Product.find(find[i].id)
      end
      redirect_to searches_path, notice: "無搜尋到此條件"
    end

    @search = products.count
    @products = products.paginate(page: params[:page], per_page: 10)

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

    category = find.where(category: params[:category_ids]).to_a
    category_name = []
    category.map {|i| category_name << i.name}

    region = find.where(region: params[:region_ids]).to_a
    region_name = []
    region.map {|i| region_name << i.name}

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

    product = [region_name,activity_kind_name,people_number_name,category_name].reject(&:empty?).reduce(:&) || []

    @products = []
    if product != []
      0.upto(product.count-1) do |i|
        @products <<  Product.find_by(name: product[i])
      end
    else
      redirect_to searches_path, notice: "無搜尋到此條件"
    end

    @search = @products.count

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
