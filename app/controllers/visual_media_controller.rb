class VisualMediaController < ApplicationController
  before_action :set_visual_medium, only: %i[ show edit update destroy ]
  before_action :get_project, only: :index

  # GET /visual_media
  def index
    @visual_media = policy_scope(@project.visual_media)
    authorize VisualMedium
  end

  # GET /visual_media/1
  def show
  end
  
  # GET /visual_media/new
  def new
    @visual_medium = VisualMedium.new
    authorize @visual_medium
  end

  # GET /visual_media/1/edit
  def edit
  end

  # POST /visual_media
  def create
    @visual_medium = VisualMedium.new(visual_medium_params)

    respond_to do |format|
      if @visual_medium.save
        format.html { redirect_to visual_medium_url(@visual_medium), notice: "Visual medium was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visual_media/1
  def update
    respond_to do |format|
      if @visual_medium.update(visual_medium_params)
        format.html { redirect_to visual_medium_url(@visual_medium), notice: "Visual medium was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visual_media/1
  def destroy
    @visual_medium.destroy

    respond_to do |format|
      format.html { redirect_to visual_media_url, notice: "Visual medium was successfully destroyed." }
    end
  end

  private
    def get_project
      @project = Project.find(params[:project_id])
    end
    
    def set_visual_medium
      @visual_medium = VisualMedium.find(params[:id])
      authorize @visual_medium
    end

    # Only allow a list of trusted parameters through.
    def visual_medium_params
      params.require(:visual_medium).permit(:title, :author, :location, :date, :url, :description, :media, :priority_index, :project_id)
    end
end
