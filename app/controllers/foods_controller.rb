class FoodsController < ApplicationController
    def index
      @foods = Product.where(category: 1)
      @regions =Region.all
      @people_numbers = PeopleNumber.all

    end

    def search
      @regions = Region.all
      @people_numbers = PeopleNumber.all

      @region = params[:region]
      @people_number = params[:people_number]


      @foods = Product.where(category: 1, region: @region, people_number: @people_number)


    end

    def show
      @detail = params[:id]
      @foods = Product.where(id: @detail)
    end
end
