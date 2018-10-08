class CostumesController < ApplicationController
  def index
    find = Product.where(category: Category.find_by(title: "舞台服").id)
    @costume = find.group("name").select("MIN(id) AS id , name")
    @costumes = Array.new
    if @costume != []
      0.upto(@costume.to_a.count-1) do |i|
        @costumes <<  Product.find_by(id: @costume[i].id)
      end
    end
    @people_numbers = PeopleNumber.all
    @regions =Region.all
  end

  def search
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    all = Product.where(category: Category.find_by(title: "舞台服").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]))
    @costume = find.group("name").select("MIN(id) AS id , name")
    if @costume != []
        @costumes = Array.new
        0.upto(@costume.to_a.count-1) do |i|
          @costumes <<  Product.find_by(id: @costume[i].id)
        end
      else
        redirect_to costumes_path, notice: "無搜尋到此條件"
    end
    @r = Array.new
    @p = Array.new
    @r = Region.where(id: params[:region_ids]).to_a
    @p = PeopleNumber.where(id: params[:people_number_ids]).to_a

  end

  def show
    @costumes = Product.where(id: params[:id])
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
