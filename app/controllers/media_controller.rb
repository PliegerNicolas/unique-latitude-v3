class MediaController < ApplicationController
  before_action :set_medium, only: %i[ edit update destroy ]

  # GET /media/new
  def new
    @medium = Medium.new
    authorize @medium
  end

  # GET /media/1/edit
  def edit
  end

  # POST /mediums
  def create
    @medium = Medium.new(medium_params)
    authorize @medium

    respond_to do |format|
      if @medium.save
        format.html { redirect_to medium_url(@medium), notice: "Medium was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media/1
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to medium_url(@medium), notice: "Medium was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  def destroy
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to media_url, notice: "Medium was successfully destroyed." }
    end
  end

  private
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
