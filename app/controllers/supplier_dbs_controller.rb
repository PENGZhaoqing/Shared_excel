class SupplierDbsController < ApplicationController

  def index
    @supplier_dbs=SupplierDb.search(search_params).order('created_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  def export
    @supplier_dbs=SupplierDb.search(search_params)
    render xlsx: "供应商数据_#{DateTime.now}", template: "supplier_dbs/export.xlsx.axlsx"
  end

  private
  def search_params
    params
  end

end
