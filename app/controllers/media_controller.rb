class MediaController < ApplicationController
  # include ActionView::RecordIdentifier
  # include RecordHelper

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
        format.html { redirect_to project_path(@project), notice: "Medium successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to project_path(@medium.project), notice: "Medium successfully updated."  }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  def destroy
    respond_to do |format|
      if @medium.destroy
        format.html { redirect_to project_path(@medium.project), notice: "Medium successfully destroyed."  }
      else
        format.html { render :destroy, status: :unprocessable_entity }        
      end
    end
  end

  private

  def medium_params
    params.require(:medium).permit(:title, :description, :author, :location, :date, :priority_index, :project_id, :visual)
  end

  def set_medium
    @medium = policy_scope(Medium).find(params[:id])
    authorize @medium
  end

  def set_project
    @project = policy_scope(Project).friendly.find(params[:project_id])
    authorize @project
  end
end