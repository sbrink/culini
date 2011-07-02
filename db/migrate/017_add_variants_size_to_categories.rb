class AddVariantsSizeToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.integer :variants_size, :limit => 4, :default => 1
    end
  end

  def self.down
    change_table :categories do |t|
       t.remove :variants_size
    end
  end

end
