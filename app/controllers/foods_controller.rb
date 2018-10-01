class FoodsController < ApplicationController
    def index
      @foods = Product.group("name").having(category: Category.find_by(title: "食物").id)
      @regions =Region.all
      @people_numbers = PeopleNumber.all

    end

    def search
      @regions = Region.all
      @people_numbers = PeopleNumber.all

      @region = params[:region]
      @people_number = params[:people_number]


      @foods = Product.where(category: Category.find_by(title: "食物").id, region_id: @region, people_number: @people_number)


    end

    def show
      @detail = params[:id]
      @foods = Product.where(id: @detail)
    end
end
