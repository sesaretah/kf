class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'jalali_date'
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for,:after_inactive_sign_up_path_for,     :after_sign_up_path_for]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :check_profile
  before_action :set_cart

  def check_profile
    if !current_user.blank? && current_user.profile.blank? && request.path != '/profiles/new' && request.path != '/profiles' && request.path != '/users/sign_out'
      redirect_to '/profiles/new'
    end
  end

  def configure_permitted_parameters
  end

  def after_sign_in_path_for(user)
    if !user.profile.blank?
      session['user_return_to'] || root_path
    else
      '/profiles/new'
    end
  end

  def after_sign_up_path_for(user)
    if !user.profile.blank?
      root_path
    else
      '/profiles/new'
    end
  end

  def after_inactive_sign_up_path_for(user)
    if !user.profile.blank?
      root_path
    else
      '/profiles/new'
    end
  end

  def load_business
    @business = Business.where(subdomain: request.subdomain).first
  end

  def set_cart
    @cart = Cart.find(cookies[:cart_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    cookies[:cart_id] = @cart.id
  end

  def create_visit
    Visit.create(visitable_type: params[:controller].classify, visitable_id: params[:id])
  end

  def currencies
    @options = [
      [t(:toman), 1]
    ]
    return @options
  end

  def rcurrencies(i)
    if i != nil
      @options = [t(:toman)]
      return @options[i.to_i-1]
    else
      return " "
    end
  end

  def extract_features(product)
    if !params[:category].blank?
      @categorizations = Categorization.where(product_id: product.id, level: [1,2,3])
      for categorization in @categorizations
        categorization.destroy
      end
      Categorization.create(product_id: product.id, category_id: params[:category], level: 1)
    end
    if !params[:subcategory].blank?
      @categorizations = Categorization.where(product_id: product.id, level: [2,3])
      for categorization in @categorizations
        categorization.destroy
      end
      Categorization.create(product_id: product.id, category_id: params[:subcategory], level: 2)
    end
    if !params[:subsubcategory].blank?
      @categorizations = Categorization.where(product_id: product.id, level: 3)
      for categorization in @categorizations
        categorization.destroy
      end
      Categorization.create(product_id: product.id, category_id: params[:subsubcategory], level: 3)
    end
    for specification in product.specifications
      specification.destroy
    end
    for key in params.keys
      if key.split('-')[0] == 'productparam'
        Specification.create(product_id: product.id, spec_id: key.split('-')[1], spec_value: params[key])
      end
    end
  end


  def prepare_items
    for item in @items
      @order_items = OrderItem.create(product_id: item[:product].id, order_id: @order.id, quantity: item[:quantity])
    end
  end

  def reciever_details
    if !current_user.blank?
      @order.user_id = current_user.id
    end
    if !@user.blank?
      @order.user_id = @user.id
    end
    @order.customer_name = params[:customer_name]
    @order.customer_mobile = params[:customer_mobile]
    @order.customer_province = params[:customer_province]
    @order.customer_address = params[:customer_address]
    @order.customer_postal_code = params[:customer_postal_code]
    if params[:reciever_name].blank?
      @order.reciever_name = params[:customer_name]
    else
      @order.reciever_name = params[:reciever_name]
    end

    if params[:reciever_mobile].blank?
      @order.reciever_mobile = params[:customer_mobile]
    else
      @order.reciever_mobile = params[:reciever_mobile]
    end

    if params[:reciever_address].blank?
      @order.reciever_address = params[:customer_address]
      @order.reciever_province = params[:customer_province]
    else
      @order.reciever_address = params[:reciever_address]
      @order.reciever_province = params[:reciever_province]
    end

    if params[:reciever_postal_code].blank?
      @order.reciever_postal_code = params[:customer_postal_code]
    else
      @order.reciever_postal_code = params[:reciever_postal_code]
    end
  end

  def order_total
    for item in @items
      @subtotal = @subtotal + item[:product].price.to_i * item[:quantity].to_i
    end
    @sale_setting = @business.sale_setting
    @taxation = @business.taxations.first
    @shipping_cost = @business.shipping_costs.where(province_id: @order.reciever_province).first
    @vat = 0
    @shipping = 0
    if !@sale_setting.blank? && !@taxation.blank? && @sale_setting.vat
      @vat = @subtotal * @taxation.percent.to_i / 100
    end
    if !@sale_setting.blank? && !@shipping_cost.blank? && @sale_setting.shipping_cost
      @shipping  = @shipping_cost.cost.to_i
    end
    @total = @subtotal + @vat + @shipping
  end

  def extract_products
    params.each do |name, value|
      if name =~ /count_(.+)$/
        @product = Product.find($1)
        @items << {product: @product, quantity: value}
      end
    end
  end

  def handle_user
    if params['will_to_register'].blank?
      if !params[:customer_mobile].blank? && !params[:customer_name].blank?
        @profile = Profile.new(name: params[:customer_name], phonenumber: params[:customer_mobile], address: params[:customer_address], province_id: params[:customer_province], postal_code: params[:postal_code])
        @profile.save
      else
        @error = {error: 'Processing',  why: 'Incomplete Data'}
      end
    else
      if !params[:customer_mobile].blank? && !params[:customer_name].blank? && !params[:password].blank? && !params[:password_confirmation].blank?
        @username = request.subdomain+'_'+params[:customer_mobile]
        @user = User.new(username: @username,mobile: params[:customer_mobile], password: params[:password], password_confirmation: params[:password_confirmation])
        if @user.save
          @profile = Profile.create(user_id: @user.id, name: params[:customer_name], phonenumber: params[:customer_mobile], address: params[:customer_address], province_id: params[:customer_province], postal_code: params[:postal_code])
        else
          @error = { error: 'Saving User' , why: @user.errors}
        end
      else
        @error = {error: 'Processing',  why: 'Incomplete Data'}
      end
    end
  end

end
