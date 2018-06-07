class FoodsController < ApplicationController
    def index
      @foods = Product.where(category: 1)
      @regions =Region.all
    end

    def search
      result = params[:region]
      @regions =Region.all

      case result
      when "1"
        @foods = Product.where(category: 1, region: 1)
      when "2"
        @foods = Product.where(category: 1, region: 2)
      when "3"
        @foods = Product.where(category: 1, region: 3)
      when "4"
        @foods = Product.where(category: 1, region: 4)
      end
    end

    def show
      @foods = Product.where(category: 1, name: "趴趴走美食工坊")
    end
end
