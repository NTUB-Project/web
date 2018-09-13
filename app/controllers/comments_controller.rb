class CommentsController < ApplicationController
  before_action :find

  def index
    @comments = Comment.all
  end

  def new
    @comment = @product_id.comments.new
  end

  def create
    @comment = @product_id.comments.new(comment_params)
    uid = current_user.id
    @comment.user_id = uid


    if @comment.save
      redirect_to root_path, notice:"ok"
    else
      redirect_to root_path, notice:"no"
    end

  end

  private
    def comment_params
      params.require(:comment).permit(:content, :product_id, :user_id)
    end

    def find
      @product_id = Product.find(params[:product_id])

    end
end
