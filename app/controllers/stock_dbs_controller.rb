class StockDbsController < ApplicationController

  before_action :login

  def index
    if logged_in_visit?
      @stock_dbs=StockDb.filter_by_type(current_visit.supplier2).search(search_params).paginate(:page => params[:page], :per_page => 20)
    elsif logged_in?
      @stock_dbs=StockDb.search(search_params).paginate(:page => params[:page], :per_page => 20)
    else
      redirect_to root_path, flash: {:danger => "Error: 请联系开发人员"}
    end
  end

  def export
    if logged_in_visit?
      @stock_dbs=StockDb.filter_by_type(current_visit.supplier2).search(search_params)
    elsif logged_in?
      @stock_dbs=StockDb.search(search_params)
    end
    render xlsx: "出库数据_#{DateTime.now}", template: "stock_dbs/export.xlsx.axlsx"
  end

  private

  def search_params
    params
  end

  def login
    if current_user.nil? && current_visit.nil?
      redirect_to root_path, flash: {:danger => "请先登陆"}
    end
  end

end
