class OrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :index, :show, :finilize]
  before_action :set_order, only: [:show, :edit, :update, :destroy, :finilize]
  before_action :load_business, only: [:index, :show, :create, :finilize]

  def finilize
    render layout: 'layouts/devise'
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = []
    if user_signed_in? && params[:uuid].blank?
      @orders = current_user.orders.where(business_id: @business.id)
    end
    if !params[:uuid].blank?
      @orders = Order.where(uuid: params[:uuid])
    end
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
