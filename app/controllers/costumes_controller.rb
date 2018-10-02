class CostumesController < ApplicationController
  def index
    @costumes = Product.group("name").having(category: Category.find_by(title: "舞台服").id).select("DISTINCT on (id) *") 
    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all


  end
end
