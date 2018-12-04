class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :upload]
  before_action :load_business, only: [:index, :new, :show,:create, :update, :edit,:upload]
  before_action :create_visit, only:[:show]
  # GET /products
  # GET /products.json

  def read_remote
    @products = @business.products

  end
  def upload

  end

  def index
    @products = Product.all
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
    extract_features
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
        extract_features
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

  def extract_features
    if !params[:category].blank?
      @categorizations = Categorization.where(product_id: @product.id, level: [1,2,3])
      for categorization in @categorizations
        categorization.destroy
      end
      Categorization.create(product_id: @product.id, category_id: params[:category], level: 1)
    end
    if !params[:subcategory].blank?
      @categorizations = Categorization.where(product_id: @product.id, level: [2,3])
      for categorization in @categorizations
        categorization.destroy
      end
      Categorization.create(product_id: @product.id, category_id: params[:subcategory], level: 2)
    end
    if !params[:subsubcategory].blank?
      @categorizations = Categorization.where(product_id: @product.id, level: 3)
      for categorization in @categorizations
        categorization.destroy
      end
      Categorization.create(product_id: @product.id, category_id: params[:subsubcategory], level: 3)
    end
    for specification in @product.specifications
      specification.destroy
    end
    for key in params.keys
      if key.split('-')[0] == 'productparam'
        Specification.create(product_id: @product.id, spec_id: key.split('-')[1], spec_value: params[key])
      end
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
