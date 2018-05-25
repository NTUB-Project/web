class CartItem
  attr_reader :product_id

  def initialize(product_id)
    @product_id = product_id
  end
  
  def increment
      @quantity = 1
  end
  
  def product
    Product.find_by(id: product_id)
  end
end
