class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:new_user, :segments, :products, :business, :upload_pict, :categories, :paginated_products, :new_product, :slider, :edit_business, :login, :check_token,:product_picts, :my_profile,  :create_order, :provinces, :my_orders, :orders, :search, :edit_product, :edit_profile, :sort]
  before_action :load_business, only: [:segments,:products, :business, :upload_pict, :categories, :paginated_products, :new_product, :is_admin, :edit_business, :slider, :product_picts, :create_order, :provinces, :my_orders, :orders, :search, :edit_product, :edit_profile, :sort]
  before_action :is_admin, only: [:new_product, :edit_business, :edit_product, :edit_profile]
  include ActionView::Helpers::TextHelper

  def segments
    @data = []
    for segment in @business.segments.order('level desc, updated_at asc')
      @products = []
      if segment.view_in_homepage
        for product in segment.produkts
          @products << {'id' => product.id, 'name' => product.title, 'price' => product.price, 'currency' => rcurrencies(product.currency), 'picture' => request.base_url + product.image('medium')}
        end
        @data << {'label' =>  segment.title,  'icon' => 'stopwatch', 'products' => @products}
      end
    end
    render :json => @data.to_json, :callback => params['callback']
  end

  def search
    @products = Product.search params[:q], with: {business_id: @business.id}, star: true
    if !@products.blank?
      render :json => {result: @products}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
    end
  end

  def sort
    if params[:category_id]
      @category = Category.find_by_id(params[:category_id])
    end
    if params[:subcategory_id]
      @subcategory = Category.find_by_id(params[:subcategory_id])
    end
    if !@category.blank? || !@subcategory.blank?
      @products = @business.products.joins(:categories).where(categories: {id: [@category, @subcategory]}).distinct.order("#{params[:attribute]} #{params[:order]}")
    else
      @products = @business.products.order("#{params[:attribute]} #{params[:order]}")
    end

    if !@products.blank?
      render :json => {result: 'OK', products: @products}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR' }.to_json , :callback => params['callback']
    end
  end

  def products
    @product = @business.products.find(params[:id])
    @images = []
    for image in @product.images('large')
      @images << request.base_url + image
    end
    @result = { 'productImageUrl' =>  @images, 'productName' => @product.title, 'description' => @product.description, 'price' => @product.price, 'currency' => rcurrencies(@product.currency), 'category' => @product.category, 'subcategory' => @product.subcategory, 'subsubcategory' => @product.subsubcategory, 'tags': []}
    render :json => @result.to_json, :callback => params['callback']
  end

  def product_picts
    @product = @business.products.find(params[:id])
    @images = []
    for image in @product.images('large')
      @images << request.base_url + image
    end
    @result = { 'productImageUrl' => @images}
    render :json => @result.to_json, :callback => params['callback']
  end

  def login
    if User.find_by_username(request.subdomain+'_'+params['mobile']).try(:valid_password?, params[:password])
      @user = User.find_by_username(request.subdomain+'_'+params['mobile'])
      render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id })}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR' }.to_json , :callback => params['callback']
    end
  end

  def check_token
    if current_user
      render :json => {result: 'OK'}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
    end
  end

  def business
    @result = { 'logo' => request.base_url+@business.image('large') , 'name' => @business.title, 'description' => @business.bio, 'instagramChannelAddr' => @business.instagram_page, 'telegramChannelAddr' => @business.telegram_channel, 'address' => @business.address, 'tel' => @business.tel, 'fax' => @business.fax, 'mobile' => @business.mobile, 'email' => @business.email, 'webpage' =>  @business.subdomain+'.'+'kaarafarin.ir'}
    render :json => @result.to_json, :callback => params['callback']
  end

  def new_user
    @user = User.new(username: request.subdomain+'_'+params['mobile'], mobile: params[:mobile], password: params['password'], password_confirmation: params['password_confirmation'])
    if @user.save
      @profile = Profile.create(user_id: @user.id, name: params[:name], surename: params[:surename])
      render :json => {token: JWTWrapper.encode({ user_id: @user.id })}.to_json, :callback => params['callback']
    else
      render :json => {error: @user.errors }.to_json , :callback => params['callback']
    end
  end

  def my_profile
    @profile = current_user.profile
    if @profile.province.blank?
      @province = nil
    else
      @province = @profile.province.name
    end
    render :json => {name: @profile.name, surename: @profile.surename, phonenumber: current_user.mobile, address: @profile.address, province: @province, postal_code: @profile.postal_code}.to_json, :callback => params['callback']
  end

  def edit_profile
    @profile = current_user.profile
    if !@profile.blank?
      @profile.name = params[:name]
      @profile.phonenumber = params[:phonenumber]
      @profile.address = params[:address]
      @profile.postal_code = params[:postal_code]
      @profile.province_id = params[:province_id]
    end
    if !@profile.blank? && @profile.save
      render :json => {result: 'OK', id: @profile.id}.to_json, :callback => params['callback']
      else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def delete_pict

  end

  def upload_pict
    @upload = Upload.new
    @upload.uploadable_type = params[:uploadable_type]
    @upload.uploadable_id = params[:uploadable_id]
    @upload.attachment_type = params[:attachment_type]
    @upload.attachment = params[:file]
    if @upload.save
      render :json => {result: 'OK' }.to_json , :callback => params['callback']
    else
      render :json => {error: 'ERROR' }.to_json , :callback => params['callback']
    end
  end

  def paginated_products
    if params[:category_id]
      @category = Category.find_by_id(params[:category_id])
    end
    if params[:subcategory_id]
      @subcategory = Category.find_by_id(params[:subcategory_id])
    end
    if !@category.blank? || !@subcategory.blank?
      @products = @business.products.joins(:categories).where(categories: {id: [@category, @subcategory]}).distinct.paginate(:page => params[:page], :per_page => params[:per_page])
    else
      @products = @business.products.paginate(:page => params[:page], :per_page => params[:per_page])
    end
    if !@products.blank?
      @total_pages = @products.total_pages
    else
      @total_pages = 0
    end
    @results = []
    for product in @products
      if !product.blank? && !product.category.blank? && !product.subcategory.blank?
        @results << {'id' => product.id, 'price' => product.price ,'name' => product.title, 'picture' => request.base_url + product.image('large'), 'category' => {'id' => product.category.id}, 'subcategory' => {'id' => product.subcategory.id}}
      end
    end
    if !@results.blank?
      render :json => {'products' => @results, 'page' => params[:page], 'per_page' => params[:per_page], 'total_pages' => @total_pages}.to_json , :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def categories
    @results = []
    @business.products.all.group_by(&:category).each do |g,p|
      if !g.blank?
        @hash = {'id' =>  g.id, 'name' => truncate(g.title, :length => 10, :omission => '..'), 'subCategories' => [], 'picture' => request.base_url + p.first.image('large')}
        @business.products.all.group_by(&:subcategory).each do |s, i|
          if !s.blank? && s.parent_id == g.id
            @hash['subCategories'] << {'id' => s.id, 'name' => truncate(s.title, :length => 10, :omission => '..'), 'picture' => request.base_url + p.first.image('large')}
          end
        end
        @results << @hash
      end
    end
    if !@results.blank?
      render :json => @results.to_json , :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def new_product
    @product = Product.new(title: params['productName'], description: params['description'], price: params['price'], currency: params['currency'])
    @product.business_id = @business.id
    if @product.save
      extract_features(@product)
      render :json => {result: 'OK', id: @product.id}.to_json, :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def edit_product
    @product = @business.products.find(params[:id])
    @product.title = params['productName']
    @product.description = params['description']
    @product.price = params['price']
    @product.currency = params['currency']
    @product.business_id = @business.id
    if @product.save
      extract_features(@product)
      render :json => {result: 'OK', id: @product.id}.to_json, :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def edit_business
    @business.title = params['name']
    @business.bio = params['description']
    @business.instagram_page = params['instagramChannelAddr']
    @business.telegram_channel = params['telegramChannelAddr']
    @business.address = params['address']
    @business.tel = params['tel']
    @business.fax = params['fax']
    @business.mobile = params['mobile']
    @business.email = params['email']
    if @business.save
      render :json => {result: 'OK', id: @business.id}.to_json, :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def slider
    @uploads = Upload.where(uploadable_type: 'Business', uploadable_id: @business.id, attachment_type: 'business_slider')
    if !@uploads.blank?
      @images = []
      for upload in @uploads
        @images <<  request.base_url + upload.attachment('large')
      end
      render :json => {'images' =>   @images }.to_json, :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def create_order
    @order = Order.new
    @subtotal = 0
    @items = []
    extract_products
    @order.user_id = current_user.id
    reciever_details
    order_total
    @order.subtotal = @subtotal
    @order.total = @total
    @order.tax = @vat
    @order.shipping = @shipping
    @order.business_id = @business.id
    @order.order_status_id = 1
    if @order.save && !@error
      prepare_items
      render :json => {result: 'OK', id: @order.id}.to_json , :callback => params['callback']
    else
      render :json => @error.to_json, status: :unprocessable_entity
    end
  end

  def orders
    @order = @business.orders.find(params[:id])
    @order_items = @order.order_items
    @items = []
    for order_item in @order_items
      @product = Product.find(order_item.product_id)
      @items << {id: @product.id, name: @product.title, image: request.base_url + @product.image('large'), quantity: order_item.quantity, unit_price: order_item.unit_price, total_price: order_item.total_price }
    end
    render :json => {order: @order, order_items: @items}.to_json , :callback => params['callback']
  end

  def my_orders
    @orders = current_user.orders.where(business_id: @business.id)
    render :json => {orders: @orders}.to_json , :callback => params['callback']
  end

  def provinces
    @provinces = Province.all
    render :json => {provinces: @provinces}.to_json , :callback => params['callback']
  end


  def is_admin
    if current_user.blank?
      head(403)
    else
      if @business.user_id != current_user.id
        head(403)
      end
    end
  end



end
