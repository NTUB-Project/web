class CartMailer < ApplicationMailer

  def matter(matter,product)
    @matter = matter
    @products = product
    if @matter.images?
      0.upto(@matter.images_urls.count-1) do |i|
        attachments["#{@matter.images[i].filename}"] = @matter.images[i].read
      end
    end
    mail to: @products.email.split('"')[1], subject:"請問一下~"
  end

  def matter_form(matter_form,product)
    @matter_form = matter_form
    @products = product
    if @matter_form.images?
      0.upto(@matter_form.images_urls.count-1) do |i|
        attachments["#{@matter_form.images[i].filename}"] = @matter_form.images[i].read
      end
    end
    mail to: @products.email.split('"')[1], subject:"請問一下~"
  end
end
