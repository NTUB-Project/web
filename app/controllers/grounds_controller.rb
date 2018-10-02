class GroundsController < ApplicationController
  def index
    @grounds = Product.group("name").having(category: Category.find_by(title: "場地").id).select("DISTINCT on id *") 
    @regions =Region.all
  end

  def search
    @regions = Region.all

    @region = params[:region]

    @grounds = Product.where(category: Category.find_by(title: "場地").id, region: @region)


  end

  def show
    @detail = params[:id]
    @grounds = Product.where(id: @detail)
    @product_id = Product.find(@detail)
    @comments = @product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)

  end
end
