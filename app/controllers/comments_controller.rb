class CommentsController < ApplicationController
  before_action :find

  def index
    @comments = Comment.all
    @comment = @product_id.comments.new
  end

  def new
    @comment = Comment.new

  end



  def create
    @comment = @product_id.comments.new(comment_params)
    uid = current_user.id
    @comment.user_id = uid
    if @comment.save
      redirect_to root_path, notice:"新增成功"
    else
      redirect_to root_path, notice:"新增失敗"
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
    redirect_to root_path, notice: "留言已刪除!"
  end


  private
    def comment_params
      params.require(:comment).permit(:content, :product_id, :user_id)
    end

    def find
      @product_id = Product.find(params[:product_id])

    end
end
