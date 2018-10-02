class CustommadeController < ApplicationController
  def index
    @custommades = Product.group("name").having(category: Category.find_by(title: "印刷").id).select("DISTINCT on id *") 
    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all

  end
end
