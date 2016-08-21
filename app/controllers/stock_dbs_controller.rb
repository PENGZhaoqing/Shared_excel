class StockDbsController < ApplicationController

  def index
    @stock_dbs=StockDb.search(search_params).paginate(:page => params[:page],:per_page => 20)
  end

  def export
    @stock_dbs=StockDb.search(search_params)
    render xlsx: "导出_#{DateTime.now.to_date}", template: "stock_dbs/export.xlsx.axlsx"
  end

  private
  def search_params
    params
  end

end
