class CartItem < ApplicationRecord
  require 'csv'
  belongs_to :cart
  belongs_to :product

  def self.to_csv(options={})
    attributes = %w{ name email }
    CSV.generate(options) do |csv|
      csv << attributes
      all.each do |product|
        csv << product.attributes.values_at(*attributes)
      end
    end.encode('gb2312', :invalid => :replace, :undef => :replace, :replace => "?")
  end
end
