class FoodsController < ApplicationController
    def index
      @find = Product.where(category: Category.find_by(title: "食物").id)
      @food = @find.group("name").select("MIN(id) AS id , name")
      @foods = Array.new
      @a = 0
      if @food != []
        @food.each do |i|
          @a+=1
        end
        0.upto(@a-1) do |i|
          @foods <<  Product.find_by(id: @food[i].id)
        end
      end
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
