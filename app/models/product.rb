class Product < ApplicationRecord
  require 'csv'
  belongs_to :category
  belongs_to :activity_kind
  belongs_to :people_number
  belongs_to :region
  belongs_to :activity_kind
  has_many :cart_items
  has_many :comments
  has_many :matters
  has_many :matter_forms
  mount_uploaders :images, ImageUploader
  mount_uploaders :budget_images, ImageUploader
  has_and_belongs_to_many :regions
  has_and_belongs_to_many :activity_kinds
  has_one :gmap

  def self.to_csv(options={})
    attributes = ["\xEF\xBB\xBF","name","tel","email","location","url"]
    CSV.generate(options) do |csv|
      csv << attributes
      all.each do |product|
        csv << product.attributes.values_at(*attributes)
      end
    end
  end
end
