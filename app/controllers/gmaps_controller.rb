class GmapsController < ApplicationController
  before_action :set_gmap, only: [:edit, :update, :destroy]

  def index
    @gmaps = Gmap.all
    @hash = Gmaps4rails.build_markers(@gmaps) do |gmap, marker|
      if gmap.product == nil
        gmap.destroy
      else
        marker.lat gmap.latitude
        marker.lng gmap.longitude
        marker.infowindow gmap.product.name
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


  # DELETE /gmaps/1
  # DELETE /gmaps/1.json
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