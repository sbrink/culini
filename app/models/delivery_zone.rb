class DeliveryZone < ActiveRecord::Base
  belongs_to :store
  belongs_to :zone

  scope :active, where(:active => true)

  delegate :postcode, :city, :area, :to => :zone
end
