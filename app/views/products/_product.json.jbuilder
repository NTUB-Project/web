json.extract! product, :id, :name, {:images => []}, :item, :url, :equipment, :limit, :activity, :description, :location, :tel, :email, :category_id,  :activity_kind_id, :people_number_id, {:region_ids => []}, :activity_kind_ids => [], :created_at, :updated_at
json.url product_url(product, format: :json)
