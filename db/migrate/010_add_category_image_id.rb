class AddCategoryImageId < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.integer :category_image_id
    end
  end

  def self.down
    change_table :categories do |t|
       t.remove :category_image_id
    end
  end
end
