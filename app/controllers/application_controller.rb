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
    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def create_visit
    Visit.create(visitable_type: params[:controller].classify, visitable_id: params[:id])
  end
end
