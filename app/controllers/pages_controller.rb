class PagesController < ApplicationController
  
  def index
    @projects = Project.find([*1..Project.count].sample(3))
  end
end
