class CostumesController < ApplicationController
  def index
    @costumes = Product.where(category: Category.find_by(title: "舞台服").id)
    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all


  end
end
