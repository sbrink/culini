class Zone < ActiveRecord::Base
  attr_accessible :country, :postcode, :city, :area, :lat, :lng, :region1, :region2, :region3
  acts_as_mappable

  validates_presence_of :country, :postcode, :city, :lat, :lng, :region1, :region2
  validates_numericality_of :lng, :lat
  has_many :delivery_zones, :dependent => :destroy
  has_many :stores, :through => :delivery_zones

  def self.search(q)
    if ("0".."9").include?(q.first)
      postcode, city, area = q.split(' ')
    else
      city, area = q.split(' ')
    end
    scope = limit(80)
    scope = scope.where(["postcode = ?",45657])
    scope = scope.where(["city = ?",city]) unless city.nil?
    scope = scope.where(["area = ?",area.sub('(','').sub(')','')]) unless area.nil?
    scope
  end


  def self.autocomplete(param)
    if param[0..4].match(/\A\d+\Z/) # only numeric
      limit(10).where(["postcode like ?","#{param[0..4]}%"]).select('postcode,city,area')
    else
      limit(10).where(["city like ?","#{param}%"]).group('city').select('city')
    end
  end

  def postcode_with_city
    "#{postcode} #{city}"
  end

  def postcode_with_city_area
    "#{postcode} #{city}#{ ('/'+area) if !area.blank? }"
  end

  def city_with_area
    "#{city}#{"-"+area if !area.blank?}"
  end

  def geo_address
    "#{postcode} #{city} #{area}, Germany"
  end

end
