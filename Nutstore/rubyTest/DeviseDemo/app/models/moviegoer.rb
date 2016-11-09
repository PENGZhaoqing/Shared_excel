class Moviegoer < ActiveRecord::Base

  has_many :reviews

  validates :provider, :presence => true
  validates :uid, :presence => true
  validates :name, :presence => true

  def self.create_with_omniauth(auth)
    Moviegoer.create!(
        :provider => auth["provider"],
        :uid => auth["uid"],
        :name => auth["info"]["name"])
  end
end
