class HomesController < ApplicationController

  def index
    @supplier_dbs=SupplierDb.paginate(:page => params[:supplier_page],:per_page => 5)
    @repertory_dbs=RepertoryDb.paginate(:page => params[:repertory_page],:per_page => 10)
    @project_dbs=ProjectDb.paginate(:page => params[:project_page],:per_page => 5)
  end

end
