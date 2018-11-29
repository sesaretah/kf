Rails.application.routes.draw do
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
  get '', to: 'businesses#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root 'home#index'
  match "/categories/get_children/:id" => "categories#get_children", :via => :get
  match "/categories/specs/:id" => "categories#specs", :via => :get
  match "/products/upload/:id" => "products#upload", :via => :get
  match "/uploads/remoted/:id" => "uploads#remoted", :via => :get

  match "/likes/liike/:id" => "likes#liike", :via => :get
  match "/likes/disliike/:id" => "likes#disliike", :via => :get
end
