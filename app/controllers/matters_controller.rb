class MattersController < ApplicationController
  def index
    @matter = current_user.matters
    @matter_form = current_user.matter_forms
    @matter = current_user.matters.paginate(page: params[:page], per_page: 10)
    @matter_form = current_user.matter_forms.paginate(page: params[:page], per_page: 10)
  end

end
