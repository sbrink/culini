class Extra < ActiveRecord::Base
  # Extensions
  acts_as_list :scope => :category

  # Security
  attr_accessible :code, :name, :description,
                  :variant_1_price, :variant_2_price,
                  :variant_3_price, :variant_4_price

  # Associations & Scopes
  belongs_to  :category
  has_many :cart_extras, :dependent => :destroy
  scope :ordered, order('position')

  # Validations
  validates_presence_of :name

  def extra_variants
    [].tap do |variant|
      variant << ExtraVariant.new(variant_1_price,1) if category.category_variants.size >= 1
      variant << ExtraVariant.new(variant_2_price,2) if category.category_variants.size >= 2
      variant << ExtraVariant.new(variant_3_price,3) if category.category_variants.size >= 3
      variant << ExtraVariant.new(variant_4_price,4) if category.category_variants.size >= 4
    end
  end

  def self.new_with_guess_extra_code(*args)
    new(args) do |extra|
      if last_extra = extra.category.extras.last
        extra.variant_1_price = last_extra.variant_1_price
        extra.variant_2_price = last_extra.variant_2_price
        extra.variant_3_price = last_extra.variant_3_price
        extra.variant_4_price = last_extra.variant_4_price
        extra.code = last_extra.next_code
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

  def extra_items
    extras.split(',').map(&:strip)
  end

  def price(variant_nr)
    send("variant_#{variant_nr}_price")
  end

end
