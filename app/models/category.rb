class Category < ActiveRecord::Base
  # Security
  attr_accessible :name, :description, :parent_id, :relevant_to_delivery_costs, :category_image_id,
                  :variant_1_name, :variant_2_name, :variant_3_name, :variant_4_name, :variants_size, :import

  # Extensions
  acts_as_list :scope => 'store_id = #{store_id} and parent_id #{(parent_id.nil?)?"IS NULL":"= #{parent_id}"}'
  acts_as_tree

  # Associations & Scopes
  has_many    :articles, :order => 'position', :dependent => :destroy
  has_many    :extras, :order => 'position', :dependent => :destroy
  belongs_to  :store
  belongs_to  :category_image

  attr_accessor :import

  def last_article
    articles.ordered.last
  end

  scope :ordered, order('position')
  scope :roots, where("parent_id IS NULL")
  scope :without, lambda { |dropped_id| where(["id != ?", (dropped_id || 0)]).order('position') }

  # Validations
  validates_presence_of :name
  validates_length_of   :name, :maximum => 40, :allow_nil => true
  validates_length_of   :description, :maximum => 1000, :allow_nil => true
  validates_inclusion_of :variants_size, :in => 1..4
  validates_presence_of :variant_1_name, :if => -> { variants_size > 1 }
  validates_presence_of :variant_2_name, :if => -> { variants_size >= 2 }
  validates_presence_of :variant_3_name, :if => -> { variants_size >= 3 }
  validates_presence_of :variant_4_name, :if => -> { variants_size >= 4 }

  delegate :image, :to => :category_image

  def image?
    !category_image_id.nil?
  end

  def self.reorder(ids)
    update_all(['position = FIND_IN_SET(id, ?)', ids.join(',')],{ :id => ids })
  end

  def category_variants
    [].tap do |variant|
      variant << CategoryVariant.new(*variant_1_name.split(" ",2)) if variants_size >= 1
      variant << CategoryVariant.new(*variant_2_name.split(" ",2)) if variants_size >= 2
      variant << CategoryVariant.new(*variant_3_name.split(" ",2)) if variants_size >= 3
      variant << CategoryVariant.new(*variant_4_name.split(" ",2)) if variants_size >= 4
    end
  end

  def as_json(options={})
    { :id => id, :name => name, :description => description, :variants => category_variants.map(&:name), :articles => articles}
  end

  #before_validation :check_import
  #
  #def check_import
  #  return if import.blank?
  #  cat = ActiveSupport::JSON.decode(import)
  #  self.name = cat["name"]
  #  self.description = cat["description"] || ""
  #  self.variants_size = cat["variants"].size
  #  self.variant_1_name = cat["variants"][0] || ""
  #  self.variant_2_name = cat["variants"][1] || ""
  #  self.variant_3_name = cat["variants"][2] || ""
  #  self.variant_4_name = cat["variants"][3] || ""
  #  cat["articles"].each do |art|
  #    articles.build(
  #      :name => art["name"],
  #      :code => art["code"] || "",
  #      :description => art["description"],
  #      :variant_1_price => art["prices"][0].to_f,
  #      :variant_2_price => art["prices"][1].to_f,
  #      :variant_3_price => art["prices"][2].to_f,
  #      :variant_4_price => art["prices"][3].to_f
  #    )
  #  end
  #end

  # Functions ---------------------------------------------------------------
  protected
  validate do
    unless parent_id.nil?
      errors.add(:parent_id, "must be empty if children exists") if children.any?
      errors.add(:parent_id, "cannot be its own parent") if id == parent_id
      errors.add(:parent_id, "must be a category in current store") unless store.categories.where(:id => parent_id).first
    end
  end

end
