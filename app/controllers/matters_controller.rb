class MattersController < ApplicationController
  def index
<<<<<<< HEAD
    @matter = current_user.matters
    @matter_form = current_user.matter_forms
    @matter = current_user.matters.paginate(page: params[:page], per_page: 2)
    @matter_form = current_user.matter_forms.paginate(page: params[:page], per_page: 2)
=======
    @matter_form = current_user.matter_forms.order('created_at desc' ).paginate(page: params[:page], per_page: 10)
    @matter = current_user.matters.order('created_at desc' ).paginate(page: params[:page], per_page: 10)
>>>>>>> 6390286f8fef3c4c4c322b6acb5459e823d81ff9
  end

end
