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
    def edit
      @food = Food.find_by(id: params[:id])
    end
    def update
      @food = Food.find_by(id: params[:id])

      if @food.update(food_params)
        # 成功
        redirect_to foods_path, notice: "資料更新成功!"
      else
        # 失敗
        render :edit
      end
    end
    def destroy
      @food = Food.find_by(id: params[:id])
      @food.destroy if @food
      redirect_to foods_path, notice: "候選人資料已刪除!"
    end
    private
    def food_params
      params.require(:food).permit(:name, :introduction, :location, :image)
    end
end
