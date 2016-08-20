class SupplierDbsController < ApplicationController
  def index
    @supplier_dbs=SupplierDb.search(search_params).paginate(:page => params[:page],:per_page => 20)
  end

  def export
    @supplier_dbs=SupplierDb.search(search_params)
    render xlsx: "导出_#{DateTime.now.to_date}", template: "supplier_dbs/export.xlsx.axlsx"
  end

  private
  def search_params
    params
  end

end
