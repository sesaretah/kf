Rails.application.routes.draw do
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
  devise_for :users
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
  match "/products/upload/:id" => "products#upload", :via => :get
  match "/uploads/remoted/:id" => "uploads#remoted", :via => :get

  match "/likes/liike/:id" => "likes#liike", :via => :get
  match "/likes/disliike/:id" => "likes#disliike", :via => :get

  match "/carts/add_to_cart/:id" => "carts#add_to_cart", :via => :get
  match "/carts/remove_from_cart/:id" => "carts#remove_from_cart", :via => :get

  match "/home/settings" => "home#settings", :via => :get

  match "/segments/check/:id" => "segments#check", :via => :get
  match "/segments/change_level/:id" => "segments#change_level", :via => :get
end
