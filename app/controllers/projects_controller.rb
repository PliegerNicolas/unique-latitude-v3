class ProjectsController < ApplicationController
  include RecordHelper
  include ActionView::RecordIdentifier
  
  before_action :authenticate_user!, only: %i[ new edit create update destroy change_status ]
  before_action :set_project, only: %i[ show edit update destroy change_status ]

  # GET /projects
  def index
    @projects = policy_scope(Project).order(date: :desc)
    # @projects = @projects.filter_by_title(params[:title]) if params[:title].present?  
    # @projects = @projects.filter_by_category(params[:category]) if params[:category].present?  
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    # Set active user as project owner
    @project.user = current_user

    authorize @project
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    # Set active user as project owner
    @project.user = current_user

    authorize @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      else
        format.html { render :destroy, status: :unprocessable_entity }
      end
    end
  end

  def change_status
    @project.change_status!

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: "Project's status was successfully changed." }
      else
        format.html { render :project, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = policy_scope(Project).friendly.find(params[:id])
      authorize @project
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :slug, :subject, :category, :description, :location, :date, :status, :user_id)
    end
end