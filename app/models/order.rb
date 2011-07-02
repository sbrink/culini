# encoding: utf-8
class Order < ActiveRecord::Base
  include AddressFunctions
  STATUS = { :new => 0, :sending => 1, :success => 2, :failed => 3 }
  STATUS_REVERSE = { 0 => :new, 1 => :sending, 2 => :success, 3 => :failed }

  attr_accessible :company, :department, :first_name, :last_name, :street, :email,
                  :postcode, :city, :address_details, :phone, :special_instructions

  attr_accessor :cart_id

  has_many :order_articles, :dependent => :destroy
  belongs_to :store
  belongs_to :cart
  scope :ordered, order('created_at desc')


  validates_presence_of :first_name, :last_name, :street, :postcode, :city, :phone
  validates_presence_of :cart_id, :on => :create
  validates_presence_of :ip_address
  validates_format_of :first_name, :last_name, :city, :with => /\A(([a-z\.-]|[äöüÄÖÜß]|\s)+)\Z/i
  validates_associated :cart, :on => :create

  validates_length_of :first_name, :last_name, :minimum => 2

  validates_numericality_of :postcode
  validates_format_of   :email, :with => /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i, :allow_nil => true

  validate do
    errors.add(:postcode, :not_in_delivery_radius) unless store.delivers_to?(postcode)
  end

  def self.process_interfax_callback!(transaction_id,status)
    return false if transaction_id.nil? || status.nil?
    logger.info("Interfax: callback for #{transaction_id} with status #{status}")
    order = find_by_fax_id(transaction_id)
    if order && order.status == :sending
      order.status = :success if status.to_i == 0
      order.status = :failed if status.to_i > 0
      order.save
    end
  end

  def check_fax_status!
    if status == :sending
      result = OrderFax.find(fax_id).first.status.to_i
      self.status = :success if result == 0
      self.status = :failed if result > 0
      save
    end
  end

  def status=(status_sym)
    write_attribute(:status_id, STATUS[status_sym])
  end

  def status
    STATUS_REVERSE[status_id]
  end


  def fax_subject
    "store_#{store.id.to_s};order_#{id.to_s}"
  end

  after_create :create_notifications
  def create_notifications
    OrderMailer.delay().order_instruction(self) if store.email_notification_enabled?
    if store.fax_notification_enabled?
      Delayed::Job.enqueue(OrderFaxJob.new(self))
      self.delay(:run_at => 3.minutes.from_now).check_fax_status!
    end
  end

  after_update :update_notifications
  def update_notifications
    OrderMailer.delay.order_confirmation(self) if email.present? && status_id_changed? && status == :success
    OrderMailer.delay.order_failed(self) if email.present? && status_id_changed? && status == :failed
  end

  before_create :transfer_cart_from_cart_id
  def transfer_cart_from_cart_id
    cart = Cart.find(cart_id)
    self.total_price = cart.total_price
    cart.cart_articles.each do |cart_article|
      order_articles.build do |order_article|
        order_article.code = cart_article.code
        order_article.quantity = cart_article.quantity
        order_article.name = cart_article.name_with_variant
        order_article.price = cart_article.price
        order_article.total_price = cart_article.total_price
        cart_article.cart_extras.each do |cart_extra|
          order_article.order_extras.build do |order_extra|
            order_extra.code = cart_extra.code
            order_extra.quantity = 1
            order_extra.name = cart_extra.name
            order_extra.price = cart_extra.price
            order_extra.total_price = cart_extra.total_price
          end
        end
      end
    end
    cart.destroy
  end

end
