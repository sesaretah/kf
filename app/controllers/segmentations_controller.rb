class SegmentationsController < ApplicationController
  before_action :set_segmentation, only: [:show, :edit, :update, :destroy]

  # GET /segmentations
  # GET /segmentations.json
  def index
    @segmentations = Segmentation.all
  end

  # GET /segmentations/1
  # GET /segmentations/1.json
  def show
  end

  # GET /segmentations/new
  def new
    @segmentation = Segmentation.new
  end

  # GET /segmentations/1/edit
  def edit
  end

  # POST /segmentations
  # POST /segmentations.json
  def create
    @segmentation = Segmentation.new(segmentation_params)

    respond_to do |format|
      if @segmentation.save
        format.html { redirect_to @segmentation, notice: 'Segmentation was successfully created.' }
        format.json { render :show, status: :created, location: @segmentation }
      else
        format.html { render :new }
        format.json { render json: @segmentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /segmentations/1
  # PATCH/PUT /segmentations/1.json
  def update
    respond_to do |format|
      if @segmentation.update(segmentation_params)
        format.html { redirect_to @segmentation, notice: 'Segmentation was successfully updated.' }
        format.json { render :show, status: :ok, location: @segmentation }
      else
        format.html { render :edit }
        format.json { render json: @segmentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /segmentations/1
  # DELETE /segmentations/1.json
  def destroy
    @segmentation.destroy
    respond_to do |format|
      format.html { redirect_to segmentations_url, notice: 'Segmentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_segmentation
      @segmentation = Segmentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def segmentation_params
      params.require(:segmentation).permit(:segment_id, :product_id, :ext_code)
    end
end
