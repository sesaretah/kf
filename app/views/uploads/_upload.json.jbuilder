json.extract! upload, :id, :uploadable_type, :uploadable_id, :attachment_type, :created_at, :updated_at
json.image upload.attachment(:original)
json.url upload_url(upload, format: :json)
