class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end


  def new
    @product = Product.find(params[:format]) #id 要改
    @comment = @product.comments.new
  end

  def edit

  end

  def create
  
    @comment = Comment.new(comment_params)

      if @comment.save
        # 成功
        redirect_to root_path, notice: "新增成功!"
      else
        # 失敗
        render :new
      end
  end

  def update

  end

  def destroy

  end

  private
    def comment_params
      params.require(:comment).permit(:content, :product_id, :user_id)
    end
end
