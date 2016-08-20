class ProjectDbsController < ApplicationController

  def index
    @project_dbs=ProjectDb.search(search_params).paginate(:page => params[:page],:per_page => 17)
  end

  def export
    @project_dbs=ProjectDb.search(search_params)
    render xlsx: "导出_#{DateTime.now.to_date}", template: "project_dbs/export.xlsx.axlsx"
  end

  private
  def search_params
    params
  end

end
