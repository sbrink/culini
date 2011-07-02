class Tag < ActiveRecord::Base
  # Security
  attr_accessible :name

  has_and_belongs_to_many :stores

  scope :ordered, order('name')

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name

end
