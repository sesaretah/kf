class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]
  def liike
    @like = Like.create(likeable_type: params[:likeable_type], likeable_id: params[:likeable_id], user_id: current_user.id )
    @item =  @like.likeable_type.classify.constantize.find(@like.likeable_id)
  end

  def disliike
    @like = Like.where(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], user_id: current_user.id).first
    @item =  @like.likeable_type.classify.constantize.find(@like.likeable_id)
    @like.destroy
  end
  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: 'Like was successfully created.' }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: 'Like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:likeable_id, :likeable_type, :user_id)
    end
end
