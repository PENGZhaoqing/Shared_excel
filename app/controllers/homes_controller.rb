class HomesController < ApplicationController

  def index
    @supplier_dbs=SupplierDb.filter(label_params).paginate(:page => params[:supplier_page],:per_page => 5)
    @supplier_labels=SupplierDb.label
    @repertory_dbs=RepertoryDb.paginate(:page => params[:repertory_page],:per_page => 18)
    @project_dbs=ProjectDb.paginate(:page => params[:project_page],:per_page => 6)
  end

  def label_params
    params[:label]
  end

end
