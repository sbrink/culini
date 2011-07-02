class OrderArticle < ActiveRecord::Base
  attr_accessible :code, :quantity, :name, :price, :total_price

  belongs_to :order
  has_many :order_extras, :dependent => :destroy

  validates_presence_of :quantity,  :name, :price, :total_price



end
