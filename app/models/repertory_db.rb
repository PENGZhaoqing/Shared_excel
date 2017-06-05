class RepertoryDb < ActiveRecord::Base

  def self.search(params)
    where('repertory_dbs.name LIKE ?', "%#{params[:name]}%")
        .where('repertory_dbs.standard LIKE ?', "%#{params[:standard]}%")
        .where('repertory_dbs.supplier LIKE ?', "%#{params[:supplier]}%")
        .where('repertory_dbs.product_code LIKE ?', "%#{params[:product_code]}%")
        .where('repertory_dbs.product_kind LIKE ?', "%#{params[:product_kind]}%")
        .where('repertory_dbs.model LIKE ?', "%#{params[:model]}%")
  end

  # def self.filter_by_type(type)
  #   where("supplier = :type", type: type)
  # end

  def self.filter_by_type(type)
    where("repertory_dbs.supplier LIKE ?", "%#{type}%")
  end

  def self.filter_by_num
    where("repertory_dbs.safe_num IS NOT NULL AND repertory_dbs.safe_num >= repertory_dbs.available")
  end

end
