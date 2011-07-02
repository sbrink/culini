class Cart < ActiveRecord::Base
  # Security
  attr_accessible

  # Associations & Scopes
  has_many :cart_articles, :dependent => :destroy
  belongs_to :store

  delegate :empty?, :to => :cart_articles

  scope :include_all, includes({:cart_articles => {:article => :category}})
  scope :fresh, where("updated_at > ?",30.minutes.ago)
  scope :stalled, where("updated_at < ?",30.minutes.ago)

  def total_price
    cart_articles.inject(0) { |sum,n| sum + n.total_price }
  end

end
