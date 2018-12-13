json.extract! order, :id, :subtotal, :tax, :shipping, :total, :business_id, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
