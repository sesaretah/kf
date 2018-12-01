class ProminentsController < ApplicationController
  before_action :set_prominent, only: [:show, :edit, :update, :destroy]

  # GET /prominents
  # GET /prominents.json
  def index
    @prominents = Prominent.all
  end

  # GET /prominents/1
  # GET /prominents/1.json
  def show
  end

  # GET /prominents/new
  def new
    @prominent = Prominent.new
  end

  # GET /prominents/1/edit
  def edit
  end

  # POST /prominents
  # POST /prominents.json
  def create
    @prominent = Prominent.new(prominent_params)

    respond_to do |format|
      if @prominent.save
        format.html { redirect_to @prominent, notice: 'Prominent was successfully created.' }
        format.json { render :show, status: :created, location: @prominent }
      else
        format.html { render :new }
        format.json { render json: @prominent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prominents/1
  # PATCH/PUT /prominents/1.json
  def update
    respond_to do |format|
      if @prominent.update(prominent_params)
        format.html { redirect_to @prominent, notice: 'Prominent was successfully updated.' }
        format.json { render :show, status: :ok, location: @prominent }
      else
        format.html { render :edit }
        format.json { render json: @prominent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prominents/1
  # DELETE /prominents/1.json
  def destroy
    @prominent.destroy
    respond_to do |format|
      format.html { redirect_to prominents_url, notice: 'Prominent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prominent
      @prominent = Prominent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prominent_params
      params.require(:prominent).permit(:product_id, :level, :user_id)
    end
end
