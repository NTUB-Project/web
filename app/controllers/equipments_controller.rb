class EquipmentsController < ApplicationController
    def index
        @equipments = Product.where(category: 2)
    end
end
