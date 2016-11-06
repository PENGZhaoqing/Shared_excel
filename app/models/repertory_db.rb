class RepertoryDb < ActiveRecord::Base

  def self.search(params)
    where('repertory_dbs.name LIKE ?', "%#{params[:name]}%")
        .where('repertory_dbs.standard LIKE ?', "%#{params[:standard]}%")
        .where('repertory_dbs.supplier LIKE ?', "%#{params[:supplier]}%")
        .where('repertory_dbs.product_code LIKE ?', "%#{params[:product_code]}%")
        .where('repertory_dbs.product_kind LIKE ?', "%#{params[:product_kind]}%")
        .where('repertory_dbs.model LIKE ?', "%#{params[:model]}%")
  end

  def self.filter_by_type(type)
    where("supplier = :type", type: type)
  end

end
