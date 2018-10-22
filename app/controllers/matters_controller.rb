class MattersController < ApplicationController
  def index
    @matter = current_user.matters
    @matter_form = current_user.matter_forms
  end

end
