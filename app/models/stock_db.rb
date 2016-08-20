class StockDb < ActiveRecord::Base

  def self.search(params)
    where('stock_dbs.product LIKE ?', "%#{params[:product]}%")
        .where('stock_dbs.import_company LIKE ?', "%#{params[:import_company]}%")
        .where('stock_dbs.import_num LIKE ?', "%#{params[:import_num]}%")
        .where('stock_dbs.export_company LIKE ?', "%#{params[:export_company]}%")
        .where('stock_dbs.export_num LIKE ?', "%#{params[:export_num]}%")
  end

end
