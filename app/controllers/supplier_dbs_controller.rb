class SupplierDbsController < ApplicationController
  def index
    @supplier_dbs=SupplierDb.paginate(:page => params[:page],:per_page => 20)
  end
end
