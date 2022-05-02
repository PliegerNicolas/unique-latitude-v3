class MediaController < ApplicationController
  before_action :set_medium, only: %i[ edit update destroy ]
  before_action :set_project, only: %i[ create edit update ]

  # GET /media
  # def index
  # end

  # GET /media/1
  #def show
  #end

  # GET /media/new
  def new
    @medium = Medium.new
    authorize @medium
  end

  # GET /media/1/edit
  def edit
  end

  # POST /media
  def create
    @medium = @project.media.create(medium_params)
    authorize @medium

    respond_to do |format|
      if @medium.save
        format.turbo_stream
        format.html { redirect_to project_url(@medium.project), notice: "Medium was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@medium)}_form", partial: "form", locals: { medium: @medium }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.turbo_stream
        format.html { redirect_to project_url(@medium.project), notice: "Medium was successfully updated." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@medium)}_form", partial: "form", locals: { medium: @medium }) }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  def destroy
    @medium.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@medium)}_item") }
      format.html { redirect_to project_url(@medium.project), notice: "Medium was successfully destroyed." }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
      authorize @project
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
      authorize @medium
    end

    # Only allow a list of trusted parameters through.
    def medium_params
      params.require(:medium).permit(:title, :description, :author, :location, :date, :priority_index, :project_id, :visual)
    end
end