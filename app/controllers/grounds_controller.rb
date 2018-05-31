class GroundsController < ApplicationController
  def index
    @grounds = Product.where(category: 3)
    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all

    case result
    when "1"
      @grounds = Product.where(category: 3, region: 1)
    when "2"
      @grounds = Product.where(category: 3, region: 2)
    when "3"
      @grounds = Product.where(category: 3, region: 3)
    when "4"
      @grounds = Product.where(category: 3, region: 4)
    end
  end
end
