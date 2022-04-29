class VisualMediaController < ApplicationController
  before_action :set_visual_medium, only: %i[ show edit update destroy ]

  # GET /visual_media or /visual_media.json
  def index
    @visual_media = VisualMedium.all
  end

  # GET /visual_media/1 or /visual_media/1.json
  def show
  end

  # GET /visual_media/new
  def new
    @visual_medium = VisualMedium.new
  end

  # GET /visual_media/1/edit
  def edit
  end

  # POST /visual_media or /visual_media.json
  def create
    @visual_medium = VisualMedium.new(visual_medium_params)

    respond_to do |format|
      if @visual_medium.save
        format.html { redirect_to visual_medium_url(@visual_medium), notice: "Visual medium was successfully created." }
        format.json { render :show, status: :created, location: @visual_medium }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visual_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visual_media/1 or /visual_media/1.json
  def update
    respond_to do |format|
      if @visual_medium.update(visual_medium_params)
        format.html { redirect_to visual_medium_url(@visual_medium), notice: "Visual medium was successfully updated." }
        format.json { render :show, status: :ok, location: @visual_medium }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visual_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visual_media/1 or /visual_media/1.json
  def destroy
    @visual_medium.destroy

    respond_to do |format|
      format.html { redirect_to visual_media_url, notice: "Visual medium was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visual_medium
      @visual_medium = VisualMedium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def visual_medium_params
      params.require(:visual_medium).permit(:title, :author, :location, :date, :url, :description, :media, :priority_index, :project_id)
    end
end
