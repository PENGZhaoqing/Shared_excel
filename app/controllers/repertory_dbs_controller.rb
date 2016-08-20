class RepertoryDbsController < ApplicationController

  def index
    @repertory_dbs=RepertoryDb.search(search_params).paginate(:page => params[:page],:per_page => 20)
  end

  def export
    @repertory_dbs=RepertoryDb.search(search_params)
    render xlsx: "导出_#{DateTime.now.to_date}", template: "repertory_dbs/export.xlsx.axlsx"
  end

  private
  def search_params
    params
  end

end
