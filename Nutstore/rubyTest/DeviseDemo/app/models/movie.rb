class Movie < ActiveRecord::Base
  
  has_many :reviews, :dependent=> :destroy 
  
  def self.all_ratings
    %w[G PG PG-13 R NC-17]
  end
  
  validates :title,:presence=>true
  validates :release_date,:presence=>true
  validate :released_1930_or_later
  validates :rating, :inclusion=>{:in=>Movie.all_ratings},:unless=>:grandfathered?
  
  def released_1930_or_later
    self.errors.add(:release_date,'must be 1930 or latter') if 
    self.release_date&&self.release_date<Date.parse('1 Nov 1930')
  end
    
  @@grandfathered_date=Date.parse('1 Nov 1968')
  
  def grandfathered?
    self.release_date&&self.release_date>=@@grandfathered_date
  end
  
  before_save :capitalize_title
  def capitalize_title
    self.title=self.title.split(/\s+/).map(&:downcase).map(&:capitalize).join(' ')
  end
  
  scope :with_good_review, lambda { |threshold|
    Movie.joins(:reviews).group(:movie_id).having(['AVG(reviews.potatoes)>?',threshold])
  }
  scope :for_kids, lambda{
    Movie.where('rating in ?',%w(G PG))
  }
  
end
# m = Movie.create!(:title => 'STAR  wars', :release_date => '27-5-1977')
# m=Movie.new(:title=>'',:rating=>'RG',:release_date=>'1929-01-01')