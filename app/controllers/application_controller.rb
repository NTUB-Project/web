class ApplicationController < ActionController::Base

  def authenticate_admin
    unless current_user.role?
      # flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end
end
