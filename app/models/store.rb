class Store < ActiveRecord::Base
  include AddressFunctions
  acts_as_mappable
  has_attached_file :header, :styles => { :thumb => "100x100>" },
   :url    => "/system/store_headers/:id/:style.:extension",
   :path   => ":rails_root/public/system/store_headers/:id/:style.:extension"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :header, :name, :domain, :password, :password_confirmation, :public_access,
                  :owner, :street, :postcode, :city, :delivery_radius, :phone, :fax, :tax_number,
                  :supervisory_authority, :store_hours_attributes, :tag_ids, :custom_css, :theme_id,
                  :minimum_order_value, :reservations_enabled, :color_global_bg, :color_header_bg,
                  :color_header_fg, :color_content_bg, :color_content_fg, :color_cart_bg, :color_cart_fg,
                  :order_enabled, :email_notification_enabled, :email_notification_address, :fax_notification_enabled

  # Associations & Scopes
  with_options(:dependent => :destroy) do |store|
    store.has_many :categories, :order => :position
    store.has_many :carts
    store.has_many :orders
    store.has_many :store_hours
    store.has_many :delivery_zones
    store.has_many :reservations
    store.has_many :zones, :through => :delivery_zones
  end

  has_and_belongs_to_many :tags
  belongs_to :user
  belongs_to :theme

  attr_accessor :delete_header

  scope :in_zones, lambda { |zone_ids| includes(:delivery_zones) & DeliveryZone.active.where("zone_id" => zone_ids) }
  scope :with_reservations_enabled, where(:reservations_enabled => true)
  scope :public_accessible, where(:public_access => true)

  # Validations
  validates_presence_of :name, :owner, :street, :postcode, :city, :user_id
  validates_numericality_of :delivery_radius, :less_than => 50
  validates_uniqueness_of :domain, :allow_nil => true
  validates_format_of :domain, :with => /^[\w\d\-_\.]+$/, :allow_nil => true
  validates_presence_of :email_notification_address, :if => :email_notification_enabled?
  validates_presence_of :minimum_order_value, :if => :order_enabled?
  validates_presence_of :delivery_radius, :if => :order_enabled?
  validates_numericality_of :minimum_order_value, :if => :order_enabled?
  validates_associated :theme

  # Functions ---------------------------------------------------------------

  def delivers_to?(postcode)
   !!zones.find_by_postcode(postcode)
  end

  private

  after_save :update_delivery_zone
  def update_delivery_zone
    return unless delivery_radius_changed?
    delivery_zones.clear
    Zone.find(:all, :origin => self, :within => delivery_radius||0, :order => :distance) .each do |zone|
      delivery_zones.build.tap { |dz| dz.zone = zone ; dz.distance = zone.distance }.save
    end
  end

  before_validation :geocode_address
  def geocode_address
    return unless street_changed? || postcode_changed? || city_changed?
    geo = Geokit::Geocoders::MultiGeocoder.geocode(address(:geo))
    geo.success ? (self.lat, self.lng = geo.lat, geo.lng) : errors.add(:address, "Could not Geocode address")
  end

end
