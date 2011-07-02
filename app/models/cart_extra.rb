class CartExtra < ActiveRecord::Base
  # Associations & Scopes
  belongs_to :cart_article, :touch => true
  belongs_to :extra

  delegate :category, :code, :name, :to => :extra
  validates_presence_of :extra_id

  def price
    extra.send("variant_#{cart_article.variant}_price")
  end

  def total_price
    price
  end

end
