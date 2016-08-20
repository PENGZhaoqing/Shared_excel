class RepertoryDb < ActiveRecord::Base

  def self.search(params)
    where('repertory_dbs.name LIKE ?', "%#{params[:name]}%")
        .where('repertory_dbs.standard LIKE ?', "%#{params[:standard]}%")
        .where('repertory_dbs.supplier LIKE ?', "%#{params[:supplier]}%")
  end

end
