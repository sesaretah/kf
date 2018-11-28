json.extract! product, :id, :title, :description, :category_id, :business_id, :user_id, :created_at, :updated_at
json.url product_url(product, format: :json)
