class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :upload]
  before_action :load_business, only: [:index, :new, :show,:create, :update, :edit,:upload]
  before_action :create_visit, only:[:show]
  # GET /products
  # GET /products.json

  def search
    @segment = Segment.find(params[:segment_id])
    @products = Product.search params[:q], star: true
  end

  def read_remote
    @products = @business.products

  end
  def upload

  end

  def index
    @catrgory_ids = []
    params.each do |name, value|
      if name =~ /category-(.+)$/
        @catrgory_ids << value
      end
    end
    @subcatrgory_ids = []
    params.each do |name, value|
      if name =~ /subcategory-(.+)$/
        @subcatrgory_ids << value
      end
    end
    if !@catrgory_ids.blank? || !@subcatrgory_ids.blank?
      @products = @business.products.all.distinct.joins(:categories).where("categories.id IN (?)", (@catrgory_ids + @subcatrgory_ids).uniq)
    else
      @products = @business.products
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show

  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.business_id = @business.id
    @product.user_id = current_user.id
    @product.save
    extract_features(@product)
    respond_to do |format|
        format.html { redirect_to "/products/upload/#{@product.id}", notice: 'Product was successfully created.' }
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      @product.business_id = @business.id
      @product.user_id = current_user.id
      if @product.update(product_params)
        extract_features(@product)
        format.html { redirect_to "/products/upload/#{@product.id}", notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :category_id, :business_id, :user_id, :price, :currency, :brand)
    end
end
