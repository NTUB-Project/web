class RentcarsController < ApplicationController
  def index
    @find = Product.where(category: Category.find_by(title: "租車").id)
    @rentcar = @find.group("name").select("MIN(id) AS id , name")
    @rentcars = Array.new
    if @rentcar != []
      0.upto(@rentcar.to_a.count-1) do |i|
        @rentcars <<  Product.find_by(id: @rentcar[i].id)
      end
    end
    @regions =Region.all
    @people_numbers = PeopleNumber.all
  end

  def search
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    all = Product.where(category: Category.find_by(title: "租車").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]))
    @rentcar = find.group("name").select("MIN(id) AS id , name")

    if @rentcar != []
      @rentcars = Array.new
      0.upto(@rentcar.to_a.count-1) do |i|
        @rentcars <<  Product.find_by(id: @rentcar[i].id)
      end
    else
      redirect_to rentcars_path, notice: "無搜尋到此條件"
    end

    @r = Array.new
    @p = Array.new
    @a = Array.new
    @r = Region.where(id: params[:region_ids]).to_a
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a
    @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a

  end

  def show
    @rentcars = Product.where(id: params[:id])
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
