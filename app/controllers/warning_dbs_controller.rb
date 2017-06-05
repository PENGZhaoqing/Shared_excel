class WarningDbsController < ApplicationController

  before_action :login

  def index
    @warning_dbs=WarningDb.order('created_at desc').paginate(:page => params[:page], :per_page => 20)
  end

  def match

    matches=RepertoryDb.joins("INNER JOIN warning_dbs ON warning_dbs.safe_num IS NOT NULL AND warning_dbs.common_num IS NOT NULL AND repertory_dbs.available IS NOT NULL
                      AND warning_dbs.supplier = repertory_dbs.supplier AND warning_dbs.product_code = repertory_dbs.product_code")

    matches.each do |match|
      data=WarningDb.find_by(product_code: match.product_code, supplier: match.supplier)
      data.update(match: true)
      RepertoryDb.find_by(id: match.id).update(safe_num: data.safe_num, common_num: data.common_num)
    end

    # WarningDb.all.each do |warning_db|
    #   next if warning_db.safe_num.nil? or warning_db.product_code.nil? or warning_db.supplier.nil? or warning_db.common_num.nil?
    #   rpd=RepertoryDb.find_by(product_code: warning_db.product_code, supplier: warning_db.supplier)
    #   next if rpd.nil? or rpd.num.nil?
    #   rpd.update(common_num: warning_db.common_num, safe_num: warning_db.safe_num)
    #   warning_db.update(match: true)
    # end

    redirect_to warning_repertory_dbs_path, flash: {success: "匹配成功"}
  end

  def match_page
    if params[:page].nil?
      page_params=1
    else
      page_params=params[:page]
    end
    data=WarningDb.order('created_at desc').paginate(:page => page_params, :per_page => 20)

    data.each do |warning_db|
      next if warning_db.safe_num.nil? or warning_db.product_code.nil? or warning_db.supplier.nil? or warning_db.common_num.nil?
      rpd=RepertoryDb.find_by(product_code: warning_db.product_code, supplier: warning_db.supplier)
      next if rpd.nil? or rpd.available.nil?
      rpd.update(common_num: warning_db.common_num, safe_num: warning_db.safe_num)
      warning_db.update(match: true)
    end


    # data.each do |warning_db|
    #   next if warning_db.safe_num.nil?
    #   RepertoryDb.all.each do |repertory_db|
    #     rdb_supplier=repertory_db.supplier
    #     rdb_product_code=repertory_db.product_code
    #     wdb_supplier=warning_db.supplier
    #     wdb_product_code=warning_db.product_code
    #     next if rdb_product_code.nil? or rdb_supplier.nil? or repertory_db.num.nil?
    #     if wdb_product_code == rdb_product_code and wdb_supplier == rdb_supplier
    #       repertory_db.update(common_num: warning_db.common_num, safe_num: warning_db.safe_num)
    #       warning_db.update(match: true)
    #       break
    #     end
    #   end
    # end
    redirect_to warning_dbs_path, flash: {success: "匹配成功"}
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
