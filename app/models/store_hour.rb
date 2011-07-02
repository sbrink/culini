class StoreHour < ActiveRecord::Base
  attr_accessible :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :holiday,
                  :opening_from, :opening_till, :reservation_from, :reservation_till
  belongs_to :store

  validates_presence_of :opening_from, :opening_till

  scope :ordered, order("opening_from")

  def opening_from_till
    "#{opening_from.to_s(:time)}-#{opening_till.to_s(:time)}"
  end

  def self.on(day)
    all.reject{|o| !o.send("#{day}?") }
  end

  def on?(day)
    send("#{day}?")
  end

  def self.opening_from_till_on(day)
    on(day).map(&:opening_from_till)
  end

end
