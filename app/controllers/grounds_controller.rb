class GroundsController < ApplicationController
  def index
    @grounds = Product.where(category: 1)
    @regions =Region.all
  end

  def search
    @regions = Region.all

    @region = params[:region]

    @grounds = Product.where(category: 1, region: @region)


  end

  def show
    @detail = params[:id]
    @grounds = Product.where(id: @detail)
  end
end
