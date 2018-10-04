class EquipmentsController < ApplicationController

    def index
      @find = Product.where(category: Category.find_by(title: "設備").id)
      @equipment = @find.group("name").select("MIN(id) AS id , name")
      @equipments = Array.new
      if @equipment != []
        0.upto(@equipment.to_a.count-1) do |i|
          @equipments <<  Product.find_by(id: @equipment[i].id)
        end
      end



        @regions =Region.all
    end

    def search
      @regions = Region.all
      @region = params[:region]
      @equipments = Product.where(category: Category.find_by(title: "設備"), region: @region)

    end

    def show
      @detail = params[:id]
      @equipments = Product.where(id: @detail)
    end

end
