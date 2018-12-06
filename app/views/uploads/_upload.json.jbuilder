json.extract! upload, :id, :uploadable_type, :uploadable_id, :attachment_type, :created_at, :updated_at
json.image upload.attachment(:large)
json.ratio upload.avatar_geometry(:original).width / upload.avatar_geometry(:large).width
json.url upload_url(upload, format: :json)
