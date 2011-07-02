class UserAddress < ActiveRecord::Base
  include AddressFunctions

  # Security
  attr_accessible :company, :department, :first_name, :last_name, :street, :email,
                  :postcode, :city, :address_details, :phone

  belongs_to :user

  scope :ordered, order('position')

  acts_as_list :scope => :user_id


  validates_presence_of :first_name, :last_name, :street, :postcode, :city, :phone


end
