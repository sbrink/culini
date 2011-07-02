class Article < ActiveRecord::Base
  # Extensions
  acts_as_list :scope => :category

  # Security
  attr_accessible :code, :name, :description,
                  :variant_1_price, :variant_2_price,
                  :variant_3_price, :variant_4_price

  # Associations & Scopes
  belongs_to  :category
  has_many :cart_articles, :dependent => :destroy
  scope :ordered, order('position')

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :code, :allow_nil => true, :allow_blank => true, :scope => :category_id

  def article_variants
    [].tap do |variant|
      variant << ArticleVariant.new(variant_1_price,1) if category.category_variants.size >= 1
      variant << ArticleVariant.new(variant_2_price,2) if category.category_variants.size >= 2
      variant << ArticleVariant.new(variant_3_price,3) if category.category_variants.size >= 3
      variant << ArticleVariant.new(variant_4_price,4) if category.category_variants.size >= 4
    end
  end

  def price(variant_nr)
    send("variant_#{variant_nr}_price")
  end

  def name_with_code
    "#{name}#{(code.blank?)? "" : " ("+code+")"}"
  end

  def self.new_with_guess_article_code(*args)
    new(args) do |article|
      if last_article = article.category.articles.ordered.last
        article.variant_1_price = last_article.variant_1_price
        article.variant_2_price = last_article.variant_2_price
        article.variant_3_price = last_article.variant_3_price
        article.variant_4_price = last_article.variant_4_price
        article.code = last_article.next_code
      end
    end
  end

  def next_code()
    return nil unless code.present?
    "".tap do |str|
      str << ((code.to_i||0)+1).to_s
      str << "." if code.last == "."
    end
  end

  def self.reorder(ids)
    update_all(['position = FIND_IN_SET(id, ?)', ids.join(',')],{ :id => ids })
  end

  def to_tag(variant)
    id.to_s + "_" + variant.to_s
  end

  def as_json(options={})
    { :id => id, :name => name, :code => code, :description => description, :prices => article_variants.map(&:price) }
  end
end
