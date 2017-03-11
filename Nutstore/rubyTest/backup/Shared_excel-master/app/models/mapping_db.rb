class MappingDb < ActiveRecord::Base
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.search(query)
    unless query.blank?
      MappingDb.where('supplier1 LIKE :search OR supplier2 LIKE :search OR auth_token LIKE :search', search: "%#{query}%")
    else
      MappingDb.all
    end
  end

end
