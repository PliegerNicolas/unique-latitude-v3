class MediaController < ApplicationController
  include RecordHelper
  include ActionView::RecordIdentifier
  
  before_action :set_medium, only: %i[ show edit update destroy ]
  before_action :set_project, only: %i[ create ]
  
  # GET /media/1
  def show
  end

  # GET /media/1/edit
  def edit
  end

  # POST projects/:id/media
  def create
    @medium = @project.media.new(medium_params)
    authorize @medium

    respond_to do |format|
      if @medium.save
        medium = Medium.new
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id_for_records(@project, medium), partial: "media/form", locals: { medium: medium, project: @project }) }
        format.html { redirect_to @project }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id_for_records(@project, @medium), partial: "media/form", locals: { medium: @medium, project: @project }) }
        format.html { redirect_to @project }
      end
    end
  end

  # PATCH/PUT /media/1
  def update
  end

  # DELETE /media/1
  def destroy
  end  

  private

  def medium_params
    params.require(:medium).permit(:title, :description, :author, :location, :date, :priority_index, :project_id, :visual)
  end

  def set_medium
    @medium = Medium.find(params[:id])
    authorize @medium
  end

  def set_project
    @project = Project.find(params[:project_id])
    authorize @project
  end
end