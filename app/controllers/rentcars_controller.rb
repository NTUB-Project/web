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
  end

  def search

  end

  def show
    @detail = params[:id]
    @rentcars = Product.where(id: @detail)
  end

end
