class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :specs, :upload]
  before_action :load_business, only: [:show, :index, :edit, :update, :create, :upload]
  def get_children
    @categories = Category.where(parent_id: params[:category_id])
    resp = []
    for k in @categories
      resp << {'title' => k.title, 'id' => k.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  def specs
    @specs = Spec.where(category_id: @category.id)
    resp = []
    for k in @specs
      resp << {'title' => k.title, 'id' => k.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to "/categories/upload/#{@category.id}", notice: 'Product was successfully updated.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to "/categories/upload/#{@category.id}", notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :parent_id, :level)
    end
end
