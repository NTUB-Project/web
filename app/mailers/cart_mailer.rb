class CartMailer < ApplicationMailer

  def say_hello_to(matter,product)
    @matter = matter
    @products = product
    mail to: @products.email, subject:"請問一下~"
  end
end
