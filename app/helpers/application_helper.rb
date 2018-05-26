module ApplicationHelper
  def index
    @regions =Region.all
  end
end
