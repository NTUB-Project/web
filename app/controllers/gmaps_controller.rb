class GmapsController < ApplicationController
  before_action :set_gmap, only: [:edit, :update, :destroy]

  def index
    product = Product.group("name").select("MIN(id) AS id , name")
    @products = []
    if product != []
      0.upto(product.to_a.count-1) do |i|
        @products <<  Product.find(product[i].id)
      end
    end
    # @products = Product.all
    @gmaps = Gmap.all
    @hash = Gmaps4rails.build_markers(@gmaps) do |gmap, marker|
      if gmap.product == nil
        gmap.destroy
      else
        case gmap.product.category.title
        when "場地"
          link = ground_path(gmap.product.id)
        when "食物"
          link = food_path(gmap.product.id)
        when "租車"
          link = rentcar_path(gmap.product.id)
        when "設備"
          link = equipment_path(gmap.product.id)
        when "印刷"
          link = custommade_path(gmap.product.id)
        when "舞台服"
          link = costume_path(gmap.product.id)
        end
        marker.lat gmap.latitude
        marker.lng gmap.longitude
        marker.infowindow "<img src=" + gmap.product.images_urls[0] + " width=50% >"+ "</p>" +
                          gmap.product.name+ "</br>"+
                          "地址：" + gmap.product.location + "</br>" +
                          "<a href=#{link}> 詳細介紹 </a>"

      end
    end
  end


  def new
    product_id = Product.find_by(location: params[:address]).id
    if Gmap.find_by(product_id: product_id).blank?
      Gmap.create(latitude: params[:lat], longitude: params[:long], address: params[:address], product_id: product_id)
    else
      Gmap.find_by(product_id: product_id).update(latitude: params[:lat], longitude: params[:long], address: params[:address])
    end
  end

  def destroy
    @gmap.destroy
    respond_to do |format|
      format.html { redirect_to gmaps_url, notice: 'Gmap was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gmap
      @gmap = Gmap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gmap_params
      params.require(:gmap).permit(:latitude, :longitude, :address)
    end
end
