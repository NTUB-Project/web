class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def add_item(vendor_id)
    found_item = items.find { |item| item.vendor_id == vendor_id }

    if found_item
      found_item.increment
    else
      @items << CartItem.new(vendor_id)
    end
  end

  def empty?
    items.empty?
  end

  def serialize
    all_items = items.map { |item|
      { "vendor_id" => item.vendor_id,
        "quantity" => item.quantity
      }
    }

    { "items" => all_items }
  end

  def self.from_hash(hash)
    if hash.nil?
      new []
    else
      new hash["items"].map { |item_hash|
        CartItem.new(item_hash["vendor_id"], item_hash["quantity"])
      }
    end
  end
end
