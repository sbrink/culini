class CategoryImageGroup < ActiveRecord::Base
  validates_presence_of :name

  scope :ordered, order("name")

  has_many :category_images, :order => "name"
end
