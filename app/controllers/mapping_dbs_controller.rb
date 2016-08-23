class MappingDbsController < ApplicationController

  before_action :admin_login

  def index
    @mapping_dbs=MappingDb.search(search_params).paginate(:page => params[:mapping_page], :per_page => 12)
  end

  def export
    @mapping_dbs=MappingDb.search(search_params)
    render xlsx: "供应商映射_#{DateTime.now}", template: "mapping_dbs/export.xlsx.axlsx"
  end

  private

  def admin_login
    unless admin?(current_user)
      redirect_to root_path, flash: {:warning => "您没有此权限"}
    end
  end

  def search_params
    params[:query]
  end

end


