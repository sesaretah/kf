class OrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :load_business, only: [:show, :create]


  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new
    @subtotal = 0
    @items = []
    extract_products
    if current_user.blank?
      handle_user
    end
    order_total
    @order.subtotal = @subtotal
    @order.business_id = @business.id
    @order.order_status_id = 1
    reciever_details
    @order.save
    prepare_items
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
    @order.reciever_address = params[:reciever_address]
    @order.reciever_province = params[:reciever_province]
    @order.reciever_postal_code = params[:reciever_postal_code]
  end

  def order_total
    for item in @items
      @subtotal = @subtotal + item[:product].price.to_i * item[:quantity].to_i
    end
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
      @profile = Profile.new(name: params[:customer_name], phonenumber: params[:customer_mobile], adderss: params[:customer_address], province_id: params[:customer_province], postal_code: params[:postal_code])
      if @profile.save
        render json: { success: true}.to_json
      end
    else
      if !params[:customer_mobile].blank? && !params[:customer_name].blank? && !params[:password].blank? && !params[:password_confirmation].blank?
        @username = request.subdomain+'_'+params[:customer_mobile]
        @user = User.new(username: @username,mobile: params[:customer_mobile], password: params[:password], password_confirmation: params[:password_confirmation])
        if @user.save
          @profile = Profile.create(user_id: @user.id, name: params[:customer_name], phonenumber: params[:customer_mobile], adderss: params[:customer_address], province_id: params[:customer_province], postal_code: params[:postal_code])
          render json: { success: true}.to_json
        else
          render json: { error: 'Saving User' , why: @user.errors}.to_json, status: :unprocessable_entity
        end
      else
        render json: {error: 'Processing',  why: 'Incomplete Data'}, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:subtotal, :tax, :shipping, :total, :business_id, :user_id)
  end
end
