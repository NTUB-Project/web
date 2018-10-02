class CustommadeController < ApplicationController
  def index
    @find = Product.where(category: Category.find_by(title: "印刷").id)
    @custommade = @find.group("name").select("MIN(id) AS id , name")
    @custommades = Array.new
    @a = 0
    if @custommade != []
      @custommade.each do |i|
        @a+=1
      end
      0.upto(@a-1) do |i|
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
