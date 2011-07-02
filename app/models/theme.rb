class Theme < ActiveRecord::Base
  has_attached_file :header,
   :url    => "/system/themes/:id/header/:style.:extension",
   :path   => ":rails_root/public/system/themes/:id/header/:style.:extension"
  has_attached_file :preview,
   :url    => "/system/themes/:id/preview/:style.:extension",
   :path   => ":rails_root/public/system/themes/:id/preview/:style.:extension"

  # Extensions
  acts_as_list

  # Associations & Scopes
  scope :ordered, order('position')

  validates_presence_of :name, :stylesheet

end
