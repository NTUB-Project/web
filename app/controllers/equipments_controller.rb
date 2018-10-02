class EquipmentsController < ApplicationController

    def index
        @equipments = Product.group("name").having(category: Category.find_by(title: "設備").id).select("DISTINCT on id *") 
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
