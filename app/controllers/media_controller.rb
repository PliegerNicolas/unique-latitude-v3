class MediaController < ApplicationController
  include RecordHelper
  include ActionView::RecordIdentifier
  
  before_action :set_medium, only: %i[ show edit update destroy cancel ]
  before_action :set_project, only: %i[ edit create update destroy ]
  
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
        format.html { redirect_to project_path(@project) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id_for_records(@project, @medium), partial: "media/form", locals: { medium: @medium, project: @project }) }
        format.html { redirect_to project_path(@project) }
      end
    end
  end

  # PATCH/PUT /media/1
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@medium) }
        format.html { redirect_to project_medium_path(@medium.project, @medium) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  def destroy
    @medium.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to project_path(@medium.project) }
    end
  end

  # DELETE /media/1/cancel
  def cancel
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to project_path(@medium.project) }
    end
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