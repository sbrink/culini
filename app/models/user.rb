class User < ActiveRecord::Base
  # Security
  attr_accessible :email, :password, :password_confirmation, :terms_of_service

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_acceptance_of :terms_of_service, :allow_nil => false, :on => :create

  has_many :stores, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_many :user_addresses, :dependent => :destroy

  def self.find_for_openid(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    if user = User.find_by_email(data["email"])
      user
    else
      User.create(:email => data["email"], :name => data["name"], :password => Devise.friendly_token[0,20])
    end
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end

end
