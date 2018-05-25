class FoodsController < ApplicationController
    def index
        @foods = Product.where(category: 1)
    end
end
