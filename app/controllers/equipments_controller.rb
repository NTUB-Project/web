class EquipmentsController < ApplicationController

    def index
      @find = Product.where(category: Category.find_by(title: "設備").id)
      @equipment = @find.group("name").select("MIN(id) AS id , name")
      @equipments = Array.new
      if @equipment != []
        0.upto(@equipment.to_a.count-1) do |i|
          @equipments <<  Product.find_by(id: @equipment[i].id)
        end
      end
      @regions =Region.all
      @activity_kinds = ActivityKind.all
    end

    def search
      @regions = Region.all
      @activity_kinds = PeopleNumber.all
      all = Product.where(category: Category.find_by(title: "設備").id)
      find = all.where(region: params[:region_ids]).or(all.where(activity_kind_id: params[:activity_kind_ids]))
      @equipment = find.group("name").select("MIN(id) AS id , name")

      if @equipment != []
          @equipments = Array.new
          0.upto(@equipment.to_a.count-1) do |i|
            @equipments <<  Product.find_by(id: @equipment[i].id)
          end
        else
          redirect_to equipments_path, notice: "無搜尋到此條件"
      end

      @r = Array.new
      @a = Array.new
      @r = Region.where(id: params[:region_ids]).to_a
      @a = ActivityKind.where(id: params[:activity_kind_ids]).to_a


    end

    def show
      @equipments = Product.where(id: params[:id])
      @product_id = Product.find(params[:id])
      @comments = @product_id.comments.order('created_at desc' ).paginate(page: params[:page], per_page: 5)
      el = 0
      sum = 0
      @comments.each do |i|
        el = i.rating
        sum = sum + el
        @avg_rating =  sum / @comments.count
      end

    end

end
