class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ promote demote ]

  after_action :verify_authorized

  def index
    @users = policy_scope(User).order(role: :desc, created_at: :asc)
    # @users = @users.filter_by_username(params[:username]) if params[:username].present?
    authorize User
  end

  def promote
    @user.promote if current_user&.promotion_permitted?(@user)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url }
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def demote
    @user.demote if current_user&.demotion_permitted?(@user)
    
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
    @user = policy_scope(User).find(params[:id])
    authorize @user
  end
end
