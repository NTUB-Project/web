class GroundsController < ApplicationController
  def index
    find = Product.where(category: Category.find_by(title: "場地").id)
    @ground = find.group("name").select("MIN(id) AS id , name")
    @grounds = Array.new
    @a = 0
    if @ground != []
      @ground.each do |i|
        @a+=1
      end
      0.upto(@a-1) do |i|
        @grounds <<  Product.find_by(id: @ground[i].id)
      end
    end
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    @r = Array.new
  end

  def search
    @regions = Region.all
    @people_numbers = PeopleNumber.all
    all = Product.where(category: Category.find_by(title: "場地").id)
    find = all.where(region: params[:region_ids]).or(all.where(people_number: params[:people_number_ids]))
    @ground = find.group("name").select("MIN(id) AS id , name")
    @grounds = Array.new
    @a = 0
    if @ground != []
      @ground.each do |i|
        @a+=1
      end
      0.upto(@a-1) do |i|
        @grounds <<  Product.find_by(id: @ground[i].id)
      end
    end
    @r = Array.new
    @p = Array.new
    @r << params[:region_ids]
    @p << params[:people_number_ids]

  end

  def show
    @detail = params[:id]
    @grounds = Product.where(id: @detail)
    @product_id = Product.find(@detail)
    @comments = @product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)

    if @comments.blank?
      @avg_rating = 0
    else
      if @avg_rating.blank?
        @avg_rating = 0
      else
        @avg_rating = @comments.average(:rating).round(2)
      end
    end

  end
end
