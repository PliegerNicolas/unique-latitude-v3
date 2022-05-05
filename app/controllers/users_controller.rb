class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ promote demote ]

  after_action :verify_authorized

  def index
    @users = policy_scope(User).order(role: :desc, created_at: :desc)
    authorize User
  end

  def promote
    @user.promote if current_user.permited?(@user)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def demote
    @user.demote if current_user.permited?(@user)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
