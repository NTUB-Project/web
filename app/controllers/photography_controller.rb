class PhotographyController < ApplicationController
  def index
    @photography = Product.where(category: 5)
    @regions =Region.all
  end

  def search
    @regions = Region.all

    @region = params[:region]

    @photography = Product.where(category: 5, region: @region)

  end

  def show
    @detail = params[:id]
    @photography = Product.where(id: @detail)
  end
end
