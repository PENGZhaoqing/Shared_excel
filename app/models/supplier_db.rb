class SupplierDb < ActiveRecord::Base

  def self.search(params)
    where('supplier_dbs.product LIKE ?', "%#{params[:product]}%")
        .where('supplier_dbs.supplier LIKE ?', "%#{params[:supplier]}%")
  end

  def self.filter(product)
    if product.nil? && !SupplierDb.all.blank?
      product=SupplierDb.first.product
    end
    SupplierDb.where(product: product)
  end

  def self.label
    all_product=SupplierDb.select(:product).map(&:product)
    uniq_hash = Hash.new(0)
    all_product.each { |v|
      uniq_hash.store(v, uniq_hash[v]+1)
    }
    return uniq_hash
  end


end
