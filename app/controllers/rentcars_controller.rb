class RentcarsController < ApplicationController
  def index
    @find = Product.where(category: Category.find_by(title: "租車").id)
    @rentcar = @find.group("name").select("MIN(id) AS id , name")
    @rentcars = Array.new
    @a = 0
    if @rentcar != []
      @rentcar.each do |i|
        @a+=1
      end
      0.upto(@a-1) do |i|
        @rentcars <<  Product.find_by(id: @rentcar[i].id)
      end
    end
    @regions =Region.all
  end

  def search

  end

  def show
    @detail = params[:id]
    @rentcars = Product.where(id: @detail)
  end

end
