class Page < ActiveRecord::Base
  attr_accessible :name, :handle, :body

  validates_presence_of :name, :handle, :body
  validates_uniqueness_of :handle

  scope :ordered, order('handle')

  def body_html
    RedCloth.new(body).to_html
  end

  def to_param
    handle
  end

end
