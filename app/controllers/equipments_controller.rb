class EquipmentsController < ApplicationController
    def index
        @equipments = Product.where(category: 2)
        @regions =Region.all
    end
end
