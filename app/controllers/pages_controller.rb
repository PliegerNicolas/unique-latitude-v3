class PagesController < ApplicationController
  
  # GET /
  def index
    @projects = policy_scope(Project).limit(3).where(published: true).order('RANDOM()')
  end
end
