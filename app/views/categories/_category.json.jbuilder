json.extract! category, :id, :title, :parent_id, :level, :created_at, :updated_at
json.url category_url(category, format: :json)
