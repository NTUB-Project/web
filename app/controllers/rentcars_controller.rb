class RentcarsController < ApplicationController
  def index
    @rentcars = Product.where(category: Category.find_by(title: "租車").id)
    @regions =Region.all
  end

  def search

  end

  def show
    @detail = params[:id]
    @rentcars = Product.where(id: @detail)
  end

end
