class CartArticle < ActiveRecord::Base
  # Associations & Scopes
  has_many :cart_extras, :dependent => :destroy
  belongs_to :cart, :touch => true
  belongs_to :article

  delegate :category, :code, :name, :to => :article

  validates_presence_of :article_id, :cart_id, :variant
  validates_inclusion_of :variant, :in => (1..4), :on => :create

  def price
    article.send("variant_#{variant}_price")
  end

  def variant_name
    category.send("variant_#{variant}_name")
  end

  def name_with_variant
    "#{article.name} #{variant_name}"
  end

  def total_price
    (price * quantity) + cart_extras.inject(0) { |sum,n| sum + n.total_price }
  end

  def decrement_quantity!
    (quantity > 1)? decrement(:quantity).save : destroy
  end

  def increment_quantity!
    increment(:quantity).save
  end

  def cycle_variant!
    write_attribute(:variant,(variant % category.variants_size)+1 )
    save
  end
end
