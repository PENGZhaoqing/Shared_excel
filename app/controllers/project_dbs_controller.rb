class ProjectDbsController < ApplicationController

  def index
    @project_dbs=ProjectDb.paginate(:page => params[:page],:per_page => 7)
  end

end
