class GroundsController < ApplicationController
    def index
        @grounds = Ground.all
    end
    def new
        @ground = Ground.new
    end
    def create
      @ground = Ground.new(ground_params)

      if @ground.save
        # 成功
        redirect_to grounds_path, notice: "新增成功!"
      else
        # 失敗
        render :new
      end
    end
    private
    def ground_params
      params.require(:ground).permit(:name, :introduction, :location)
    end
end
