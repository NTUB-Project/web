class MattersController < ApplicationController
  def index
    @matter = Matter.all
    @matter_form = MatterForm.all
  end

end
