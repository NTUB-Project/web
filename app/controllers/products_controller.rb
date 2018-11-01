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
    1.upto(product_params.values[13].count-1) do |region|
      1.upto(product_params.values[14].count-1) do |activity_kind|
        @product = Product.new(product_params)
        @product.region_id = product_params.values[13][region]
        @product.activity_kind_id = product_params.values[14][activity_kind]
        @product.save
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
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
    Gmap.find_by(product_id: @product.id).destroy
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
      params.require(:product).permit(:name, {:images => []}, :item, :url, :equipment, :limit, :activity, :description, :location, :tel, :email, :category_id,  :activity_kind_id, :people_number_id, {:region_ids => []}, :activity_kind_ids => [])
    end
end
