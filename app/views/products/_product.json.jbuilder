json.extract! product, :id, :name, :image, :description, :location, :tel, :email, :category_id, :region_id, :activity_kind_id, :people_number_id, :created_at, :updated_at
json.url product_url(product, format: :json)
