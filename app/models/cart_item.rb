class CartItem
  attr_reader :vendor_id, :quantity

  def initialize(vendor_id, quantity = 1)
    @vendor_id = vendor_id
    @quantity = quantity
  end

  def increment(n = 0)
    @quantity += n
  end

  def food
    Food.find_by(id: vendor_id)
  end

end
