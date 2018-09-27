class CommentsController < ApplicationController
  before_action :authenticate_user! , :only => [:new,:edit,:destroy]
  before_action :find

  def new
    @comment = @product_id.comments.new
  end

  def create
    if user_signed_in?
      if Comment.find_by(user_id: current_user.id).blank?
        @comment = @product_id.comments.new(comment_params)
        uid = current_user.id
        @comment.user_id = uid
        if @comment.save
          redirect_back(fallback_location: root_path)
        else
          redirect_to root_path, notice:"新增失敗"
        end
      else
        redirect_to root_path, notice:"您已留言過！"
      end
    else
      redirect_to new_user_session_url, notice:"請先登入再嘗試留言"
    end
    
  end

  def edit
    @product_id = Product.find(params[:product_id])
    @comment = @product_id.comments.find(params[:id])
  end

  def update
    @product_id = Product.find(params[:product_id])
    @comment = @product_id.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to root_path, notice:"更新成功"
    else
      redirect_to root_path, notice:"更新失敗"
    end

  end

  def destroy
    @product_id = Product.find(params[:product_id])
    @comment = @product_id.comments.find(params[:id])
    @comment.destroy if @comment
    redirect_back(fallback_location: root_path)
  end



  private
    def comment_params
      params.require(:comment).permit(:content, :product_id, :user_id, :rating, :images => [])
    end

    def find
      @product_id = Product.find(params[:product_id])
    end
end
