class FoodsController < ApplicationController
    def index
        @foods = Food.all
    end
    def new
        @food = Food.new
    end
    def create
      @food = Food.new(food_params)

      if @food.save
        # 成功
        redirect_to foods_path, notice: "新增成功!"
      else
        # 失敗
        render :new
      end
    end
    private
    def food_params
      params.require(:food).permit(:name, :introduction, :location)
    end
end
