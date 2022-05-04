class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = policy_scope(User)
    authorize User # Because after_action :verify_authorized on all
  end
end
