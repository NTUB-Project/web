class CustommadeController < ApplicationController
  def index
    @find = Product.where(category: Category.find_by(title: "印刷").id)
    @custommade = @find.group("name").select("MIN(id) AS id , name")
    @custommades = Array.new
    if @custommade != []
      0.upto(@custommade.to_a.count-1) do |i|
        @custommades <<  Product.find_by(id: @custommade[i].id)
      end
    end

    @regions =Region.all
  end

  def search
    result = params[:region]
    @regions =Region.all

  end
end
