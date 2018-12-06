class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :except => [:new, :update, :create]
  before_action :load_business, only: [:create]
  def new
    super
  end

  def create
    @username = request.subdomain+'_'+params[:user][:mobile]
    @user = User.new(username: @username,mobile: params[:user][:mobile], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: 'Welcome' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    super
  end

end
