class CommentsController < ApplicationController
  before_action :authenticate_user! , :only => [:new,:edit,:destroy]
  before_action :find

  def index
    @comments = Comment.where(product_id: @product_id)
  end

  def create
    if user_signed_in?
      if Comment.find_by(user_id: current_user.id, product_id: @product_id).blank?
        @comment = @product_id.comments.new(comment_params)
        uid = current_user.id
        @comment.user_id = uid
        if @comment.save
          redirect_back(fallback_location: root_path, notice: "成功留言！")
        else
          redirect_back(fallback_location: root_path, notice: "留言失敗")
        end
      else
        redirect_back(fallback_location: root_path, notice: "你已留言過！")
      end
    else
      redirect_to new_user_session_url, notice:"請先登入再嘗試留言"
    end

  end

  def edit
    session[:return_to] ||= request.referer
    @product_id = Product.find(params[:product_id])
    @comment = @product_id.comments.find(params[:id])
  end

  def update
    @product_id = Product.find(params[:product_id])
    @comment = @product_id.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to session.delete(:return_to) , notice:"更新成功"
    else
      redirect_to root_path, notice:"更新失敗"
    end

  end

  def destroy
    
    @comment = @product_id.comments.find(params[:id])
    @comment.destroy if @comment
    redirect_back(fallback_location: root_path, notice: "成功刪除留言")
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :product_id, :user_id, :rating, :images => [])
    end

    def find
      @product_id = Product.find(params[:product_id])
    end
end
