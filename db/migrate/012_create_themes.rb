class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes, :force => true do |t|
      t.string   :name, :limit => 32
      t.string   :stylesheet, :limit => 32
      t.string   :header_file_name
      t.string   :header_content_type
      t.integer  :header_file_size
      t.datetime :header_updated_at
      t.string   :preview_file_name
      t.string   :preview_content_type
      t.integer  :preview_file_size
      t.datetime :preview_updated_at
      t.integer  :position
      t.timestamps
    end

    change_table :stores do |t|
      t.integer :theme_id, :default => 1, :null => false
      t.text :theme_css
    end

  end

  def self.down
    change_table :stores do |t|
       t.remove :theme_id
       t.remove :theme_css
    end
    drop_table :themes
  end
end
