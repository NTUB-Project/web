class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @product = Product.group(:name).select("MIN(id) AS id , name")
    @a = []
    if @product != []
      0.upto(@product.to_a.count-1) do |i|
        @a <<  Product.find_by(id: @product[i].id)
      end
    end

    @grounds = []
    @foods = []
    @rentcars = []
    @equipments = []
    @custommade = []
    @costumes = []

    @a.map{ |i|
      case i.category_id
      when 1
        @grounds << i
      when 2
        @foods << i
      when 3
        @rentcars << i
      when 4
        @equipments << i
      when 5
        @custommade << i
      when 6
        @costumes << i
      end
    }
    @ground = @grounds.count
    @food = @foods.count
    @rentcar = @rentcars.count
    @equipment = @equipments.count
    @custommad = @custommade.count
    @costume = @costumes.count

  end

  # GET /products/1
  # GET /products/1.json
  def show

  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    number = 14  if product_params.values.count == 16
    number = 15  if product_params.values.count == 17
    1.upto(product_params.values[number].count-1) do |region|
      1.upto(product_params.values[number+1].count-1) do |activity_kind|
        @product = Product.new(product_params)
        @product.region_id = product_params[:region_ids][region]
        @product.activity_kind_id = product_params[:activity_kind_ids][activity_kind]
        @product.budget_option = params[:Budget]
        @product.min_price = @product.budget.split(",")[2].to_i / @product.budget.split(",")[1].to_i if @product.budget_option == "按時段收費"
        @product.save
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    number = 13  if product_params.values.count == 15
    number = 14  if product_params.values.count == 16
    number = 15  if product_params.values.count == 17
    new_count = (product_params.values[number+1].count-1) * (product_params.values[number].count-1)
    old_count = Product.where(name: @product.name).count
    if new_count-old_count == 0
      product = Product.where(name: @product.name).ids.sort!
      count = new_count - 1
      1.upto(product_params.values[number].count-1) do |region|
        1.upto(product_params.values[number+1].count-1) do |activity_kind|
          products = Product.find(product[count])
          products.update(product_params)
          products.region_id = product_params[:region_ids][region]
          products.activity_kind_id = product_params[:activity_kind_ids][activity_kind]
          products.budget_option = params[:Budget]
          products.min_price = products.budget.split(",")[2].to_i / products.budget.split(",")[1].to_i if products.budget_option == "按時段收費"
          count = count - 1
          products.save
        end
      end
    end

    if new_count-old_count > 0
      @product.region_id = product_params.values[number][1].to_i
      @product.activity_kind_id = product_params.values[number+1][1].to_i
      @product.update(product_params)
      1.upto(Product.where(name: @product.name).ids.count-1) do |i|
        Product.find(Product.where(name: @product.name).ids.sort![1]).destroy
      end
      1.upto(product_params.values[number].count-1) do |region|
        1.upto(product_params.values[number+1].count-1) do |activity_kind|
          product = Product.new(product_params)
          product.region_id = product_params[:region_ids][region]
          product.activity_kind_id = product_params[:activity_kind_ids][activity_kind]
          products.budget_option = params[:Budget]
          products.min_price = products.budget.split(",")[2].to_i / products.budget.split(",")[1].to_i if products.budget_option == "按時段收費"
          product.save
        end
      end
      Product.find(Product.where(name: @product.name).ids.sort![1]).destroy
    end

    if new_count-old_count < 0
      1.upto(old_count-new_count) do |i|
        Product.find(Product.where(name: @product.name).ids.sort![-1]).destroy
      end
      product = Product.where(name: @product.name).ids.sort!
      count = new_count - 1
      1.upto(product_params.values[number].count-1) do |region|
        1.upto(product_params.values[number+1].count-1) do |activity_kind|
          products = Product.find(product[count])
          products.update(product_params)
          products.region_id = product_params[:region_ids][region]
          products.activity_kind_id = product_params[:activity_kind_ids][activity_kind]
          products.budget_option = params[:Budget]
          products.min_price = products.budget.split(",")[2].to_i / products.budget.split(",")[1].to_i if products.budget_option == "按時段收費"
          count = count - 1
          products.save
        end
      end
    end

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end


  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    Product.where(name: @product.name).ids.map{|i|
      Matter.find_by(product_id: i).destroy if Matter.find_by(product_id: i) != nil
      MatterForm.find_by(product_id: i).destroy if MatterForm.find_by(product_id: i) != nil
      CartItem.find_by(product_id: i).destroy if CartItem.find_by(product_id: i) != nil
      Comment.find_by(product_id: i).destroy if Comment.find_by(product_id: i) != nil
      Gmap.find_by(product_id: i).destroy if Gmap.find_by(product_id: i) != nil
    }
    Product.where(name: @product.name).destroy_all
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, {:images => []},{:budget_images => []}, :budget, :item, :url, :equipment, :limit, :activity, :description, :location, :tel, :email, :category_id,  :activity_kind_id, :people_number_id, {:region_ids => []}, :activity_kind_ids => [])
    end
end
