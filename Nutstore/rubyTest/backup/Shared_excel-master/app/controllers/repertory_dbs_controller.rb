class RepertoryDbsController < ApplicationController

  before_action :login

  def index
    if logged_in_visit?
      @repertory_dbs=RepertoryDb.filter_by_type(current_visit.supplier2).search(search_params).order('created_at desc').paginate(:page => params[:page], :per_page => 20)
    elsif logged_in?
      @repertory_dbs=RepertoryDb.search(search_params).order('created_at desc').paginate(:page => params[:page], :per_page => 20)
    else
      redirect_to root_path, flash: {:danger => "Error: 请联系开发人员"}
    end
  end

  def warning
    @repertory_dbs=RepertoryDb.filter_by_num.search(search_params).order('created_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  def update
    @repertory_data = RepertoryDb.find_by_id(params[:id])
    @repertory_data.update_attributes(repertory_params)
    redirect_to repertory_dbs_path(page: params[:page])
  end

  def export
    if logged_in_visit?
      @repertory_dbs=RepertoryDb.filter_by_type(current_visit.supplier2).search(search_params)
    elsif logged_in?
      @repertory_dbs=RepertoryDb.search(search_params)
    end
    render xlsx: "库存数据_#{DateTime.now}", template: "repertory_dbs/export.xlsx.axlsx"
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

  def repertory_params
    params.require(:repertory_db).permit(:warning)
  end

end
