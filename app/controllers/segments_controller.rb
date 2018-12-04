class SegmentsController < ApplicationController
  before_action :set_segment, only: [:show, :edit, :update, :destroy, :check, :change_level, :add_to_segment, :remove_from_segment]
  before_action :load_business, only: [:create,:check, :change_level, :add_to_segment, :destroy, :remove_from_segment]
  # GET /segments
  # GET /segments.json

  def remove_from_segment
    @product = Product.find(params[:product_id])
    @segmentation = @segment.segmentations.where(product_id: @product.id).first
    @segmentation.destroy
  end
  def add_to_segment
    @product = Product.find(params[:product_id])
    @segment.segmentations.create(product_id: @product.id)
  end
  def change_level
    if params[:to] == 'up'
      @segment.level = @segment.level.to_i + 1
    else
      @segment.level = @segment.level.to_i - 1
    end
    @segment.save
  end

  def check
    if params[:to] == 'check'
      @segment.view_in_homepage = true
    else
      @segment.view_in_homepage = false
    end
    @segment.save
  end

  def index
    @segments = Segment.all
  end

  # GET /segments/1
  # GET /segments/1.json
  def show
  end

  # GET /segments/new
  def new
    @segment = Segment.new
  end

  # GET /segments/1/edit
  def edit
  end

  # POST /segments
  # POST /segments.json
  def create
    @segment = Segment.new(segment_params)
    @segment.business_id = @business.id
    respond_to do |format|
      if @segment.save
        format.html { redirect_to @segment, notice: 'Segment was successfully created.' }
        format.json { render :show, status: :created, location: @segment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /segments/1
  # PATCH/PUT /segments/1.json
  def update
    respond_to do |format|
      if @segment.update(segment_params)
        format.html { redirect_to @segment, notice: 'Segment was successfully updated.' }
        format.json { render :show, status: :ok, location: @segment }
      else
        format.html { render :edit }
        format.json { render json: @segment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /segments/1
  # DELETE /segments/1.json
  def destroy
    @segment.destroy
    respond_to do |format|
      format.html { redirect_to segments_url, notice: 'Segment was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_segment
      @segment = Segment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def segment_params
      params.require(:segment).permit(:title)
    end
end
