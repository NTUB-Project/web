class EquipmentsController < ApplicationController
    def index
        @equipments = Product.where(category: 2)
        @regions =Region.all
    end

    def search
      @regions = Region.all

      @region = params[:region]

      @equipments = Product.where(category: 2, region: @region)


    end

    def show
      @detail = params[:id]
      @equipments = Product.where(id: @detail)
    end

end
