class CostumesController < ApplicationController
  def index
    @find = Product.where(category: Category.find_by(title: "舞台服").id)
    @costume = @find.group("name").select("MIN(id) AS id , name")
    @costumes = Array.new
    @a = 0
    if @costume != []
      @costume.each do |i|
        @a+=1
      end
      0.upto(@a-1) do |i|
        @costumes <<  Product.find_by(id: @costume[i].id)
      end
    end

    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all


  end
end
