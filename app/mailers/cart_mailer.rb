class CartMailer < ApplicationMailer

  def matter(matter,product)
    @matter = matter
    @products = product
    mail to: @products.email.split('"')[1], subject:"請問一下~"
  end

  def matter_form(matter_form,product)
    @matter_form = matter_form
    @products = product
    mail to: @products.email.split('"')[1], subject:"請問一下~"
  end
end
