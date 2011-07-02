class OrderExtra < ActiveRecord::Base
  attr_accessible :code, :name, :price, :total_price

  belongs_to :order_article

  validates_presence_of :quantity, :name, :price, :total_price

end
