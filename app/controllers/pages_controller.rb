class PagesController < ApplicationController
  
  def index
    @projects = Project.limit(3).where(published: true).order('RANDOM()')
  end
end
