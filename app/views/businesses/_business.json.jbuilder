json.extract! business, :id, :title, :user_id, :tel, :mobile, :fax, :address, :bio, :telegram_channel, :instagram_page, :email, :created_at, :updated_at
json.url business_url(business, format: :json)
