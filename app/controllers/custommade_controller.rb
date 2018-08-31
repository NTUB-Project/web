class CustommadeController < ApplicationController
  def index
    @custommades = Product.where(category: 6)
    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all

    case result
    when "1"
      @foods = Product.where(category: 7, region: 1)
    when "2"
      @foods = Product.where(category: 7, region: 2)
    when "3"
      @foods = Product.where(category: 7, region: 3)
    when "4"
      @foods = Product.where(category: 7, region: 4)
    end

  end
end
