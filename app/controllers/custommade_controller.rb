class CustommadeController < ApplicationController
  def index
    custommade = Product.where(category: Category.find_by(title: "印刷").id).group("name").select("MIN(id) AS id , name")
    @custommades = []
    if custommade != []
      0.upto(custommade.to_a.count-1) do |i|
        @custommades <<  Product.find_by(id: custommade[i].id)
      end
    end
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
    else
      redirect_to custommade_index_path, notice: "無搜尋到此條件"
    end
    #checkbox
    @regions = Region.all
    @r = Region.where(id: params[:region_ids]).to_a
  end

  def show
    @custommades = Product.where(id: params[:id])
    product_id = Product.find(params[:id])
    @comments = product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)
    el = 0
    sum = 0
    @comments.each do |i|
      el = i.rating
      sum = sum + el
      @avg_rating =  sum / @comments.count
    end
  end


end
