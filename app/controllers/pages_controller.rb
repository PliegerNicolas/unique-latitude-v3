class PagesController < ApplicationController
  
  # GET /
  def index
    @projects = policy_scope(Project).limit(3).where(status: "published").order('RANDOM()')
  end
end
