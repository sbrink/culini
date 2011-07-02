class CreateCategoryImageGroups < ActiveRecord::Migration
  def self.up
    create_table :category_image_groups, :force => true do |t|
      t.string   :name, :limit => 32
      t.timestamps
    end

    change_table :category_images do |t|
      t.integer :category_image_group_id
      t.remove :group
    end
  end

  def self.down
    change_table :stores do |t|
       t.remove :category_image_group_id
       t.string :group
    end
    drop_table :category_image_groups
  end

end
