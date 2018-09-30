class CartMailer < ApplicationMailer

  def say_hello_to(matter,product,current_user)
    @matter = matter
    @products = product
    @current_user = current_user

    mail to: @products.email, subject:"請問一下~"
  end
end
