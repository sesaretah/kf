class BusinessesController < ApplicationController
  before_action :set_business, only: [:edit, :update, :destroy]
  before_action :load_business, only: [:index, :show]
  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show

  end

  # GET /businesses/new
  def new
    @business = Business.new
  end

  # GET /businesses/1/edit
  def edit
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)
    @business.save
    extract_classifications
    respond_to do |format|
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    @business.update(business_params)
    extract_classifications
    respond_to do |format|
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def extract_classifications
    @classifications = Classification.where(business_id: @business.id)
    for classification in @classifications
      classification.destroy
    end
    for key in params.keys
      if key.split('-')[0] == 'category'
        Classification.create(business_id: @business.id, category_id: params[key])
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:title, :user_id, :tel, :mobile, :fax, :address, :bio, :telegram_channel, :instagram_page, :email, :subdomain)
    end
end
