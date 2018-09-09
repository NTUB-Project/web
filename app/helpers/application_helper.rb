module ApplicationHelper

  def index
    @regions =Region.all
  end

  def icon_link_to(label, path, icon)
    link_to path do
      content_tag :i, class: "fa fa-#{icon}" do
        label
      end
    end
  end




end
