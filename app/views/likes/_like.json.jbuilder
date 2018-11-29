json.extract! like, :id, :likeable_id, :likeable_type, :user_id, :created_at, :updated_at
json.url like_url(like, format: :json)
