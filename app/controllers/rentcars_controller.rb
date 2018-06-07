class RentcarsController < ApplicationController
  def index
    @rentcars = Product.where(category: 4)
    @regions =Region.all
  end

  def search

  end

  def show
    @detail = params[:id]
    @rentcars = Product.where(id: @detail)
  end

end
