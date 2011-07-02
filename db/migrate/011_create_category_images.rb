class CreateCategoryImages < ActiveRecord::Migration
  def self.up
    create_table :category_images, :force => true do |t|
      t.string   :name, :limit => 32
      t.string   :group, :limit => 32
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :category_images
  end
end
