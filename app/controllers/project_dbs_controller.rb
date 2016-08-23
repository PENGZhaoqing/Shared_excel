class ProjectDbsController < ApplicationController

  def index
    @project_dbs=ProjectDb.search(search_params).paginate(:page => params[:page],:per_page => 17)
  end

  def export
    @project_dbs=ProjectDb.search(search_params)
    render xlsx: "立项数据_#{DateTime.now}", template: "project_dbs/export.xlsx.axlsx"
  end

  private
  def search_params
    params
  end

end
