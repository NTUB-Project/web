class CartMailer < ApplicationMailer
  def say_hello_to(items,b)
    @items = items
    @b = b
    mail to: @b.email, subject:"請問一下~"
  end
end