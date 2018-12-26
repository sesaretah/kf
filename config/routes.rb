Rails.application.routes.draw do
  resources :provinces
  resources :order_statuses
  resources :order_items
  resources :orders
  resources :pixels
  resources :themes
  resources :faqs
  resources :visits
  resources :segmentations
  resources :segments
  resources :cart_items
  resources :carts
  resources :prominents
  resources :likes
  resources :uploads
  resources :specifications
  resources :profiles
  #devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :specs
  resources :categories
  resources :classifications
  resources :categorizations
  resources :products
  resources :businesses
  get '', to: 'home#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root 'home#index'

  match "/categories/get_children/:id" => "categories#get_children", :via => :get
  match "/categories/specs/:id" => "categories#specs", :via => :get
  match "/categories/upload/:id" => "categories#upload", :via => :get

  match "/products/upload/:id" => "products#upload", :via => :get
  match "/uploads/remoted/:id" => "uploads#remoted", :via => :get

  match "/likes/liike/:id" => "likes#liike", :via => :get
  match "/likes/disliike/:id" => "likes#disliike", :via => :get

  match "/carts/add_to_cart/:id" => "carts#add_to_cart", :via => :get
  match "/carts/remove_from_cart/:id" => "carts#remove_from_cart", :via => :get

  match "/home/settings" => "home#settings", :via => :get

  match "/segments/check/:id" => "segments#check", :via => :get
  match "/segments/change_level/:id" => "segments#change_level", :via => :get
  match "/segments/add_to_segment/:id" => "segments#add_to_segment", :via => :get
  match "/segments/remove_from_segment/:id" => "segments#remove_from_segment", :via => :get

  match "/products/search/:id" => "products#search", :via => :get

  match "/api/segments" => "api#segments", :via => :get
  match "/api/products/:id" => "api#products", :via => :get
  match "/api/business" => "api#business", :via => :get
  match "/api/new_user" => "api#new_user", :via => :post
  match "/api/my_profile" => "api#my_profile", :via => :get
  match "/api/upload_pict" => "api#upload_pict", :via => :post
  match "/api/categories" => "api#categories", :via => :get
  match "/api/paginated_products" => "api#paginated_products", :via => :get
  match "/api/slider" => "api#slider", :via => :get
  match "/api/login" => "api#login", :via => :get
  match "/api/product_picts/:id" => "api#product_picts", :via => :get
  match "/api/provinces" => "api#provinces", :via => :get
  match "/api/orders/:id" => "api#orders", :via => :get
  match "/api/my_orders" => "api#my_orders", :via => :get
  match "/api/search" => "api#search", :via => :get
  match "/api/edit_product" => "api#edit_product", :via => :get
  match "/api/sort" => "api#sort", :via => :get


  match "/api/new_product" => "api#new_product", :via => :post
  match "/api/edit_business" => "api#edit_business", :via => :post
  match "/api/check_token" => "api#check_token", :via => :post
  match "/api/create_order" => "api#create_order", :via => :post


  match "/faqs/change_rank/:id" => "faqs#change_rank", :via => :get

  match "/businesses/change_theme/:id" => "businesses#change_theme", :via => :get
  match "/businesses/upload/:id" => "businesses#upload", :via => :get
  match "/sale_settings/remote_switch" => "sale_settings#remote_switch", :via => :get

  match "/home/sales" => "home#sales", :via => :get

  match "/orders/finilize/:id" => "orders#finilize", :via => :get

end
