class CustommadeController < ApplicationController
  def index
    @custommades = Product.where(category: Category.find_by(title: "印刷").id)
    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all

  end
end
