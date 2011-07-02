class Reservation < ActiveRecord::Base
  include AddressFunctions

  attr_accessible :number_of_guests, :first_name, :last_name, :phone, :email, :booked_on, :booked_from

  scope :ordered, order("booked_on desc")
  scope :future, where("booked_on >= ?", Time.now)
  scope :past, where("booked_on < ?", Time.now)

  validates_presence_of :first_name, :last_name, :phone, :email, :number_of_guests, :number_of_guests, :booked_on, :booked_from

  validates_numericality_of :number_of_guests, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 6

end
