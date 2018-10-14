class Cart < ApplicationRecord
  require 'csv'
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product

  def self.to_csv(options={})
    attributes = %w{ id name email  }
    CSV.generate(options) do |csv|
      csv << attributes
      all.each do |product|
        csv << product.attributes.values_at(*attributes)
      end
    end.encode('gb2312', :invalid => :replace, :undef => :replace, :replace => "?")
  end

end
