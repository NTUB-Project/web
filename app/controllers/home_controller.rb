class HomeController < ApplicationController
  def index
    @activity_kinds = ActivityKind.all
    @regions = Region.all
    @people_numbers = PeopleNumber.all
  end

  def about
  end


end
