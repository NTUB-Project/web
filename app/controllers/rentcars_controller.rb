class RentcarsController < ApplicationController
  def index
    @rentcars = Product.group("name").having(category: Category.find_by(title: "租車").id).select("DISTINCT on id *") 
    @regions =Region.all
  end

  def search

  end

  def show
    @detail = params[:id]
    @rentcars = Product.where(id: @detail)
  end

end
