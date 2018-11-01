class MattersController < ApplicationController
  def index
    @matter_form = current_user.matter_forms.order('created_at desc' ).paginate(page: params[:page], per_page: 10)
    @matter = current_user.matters.order('created_at desc' ).paginate(page: params[:page], per_page: 10)
  end

end
