class CategoryImage < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumb => "200x200>", :medium => "400x400>" },
   :url    => "/system/category_images/:id/:style.:extension",
   :path   => ":rails_root/public/system/category_images/:id/:style.:extension"

  validates_presence_of :name, :category_image_group_id
  validates_uniqueness_of :name
  validates_length_of :name, :within => 3..25
  validates_attachment_presence :image

  belongs_to :category_image_group

  scope :ordered, order("'group',name")
end
