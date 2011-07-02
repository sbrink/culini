class DeleteCategoryVariantActive < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
       t.remove "variant_1_description"
       t.remove "variant_2_description"
       t.remove "variant_3_description"
       t.remove "variant_4_description"
       t.remove "variant_1_active"
       t.remove "variant_2_active"
       t.remove "variant_3_active"
       t.remove "variant_4_active"
    end
  end

  def self.down
    change_table :categories do |t|
      t.string   "variant_1_description"
      t.string   "variant_2_description"
      t.string   "variant_3_description"
      t.string   "variant_4_description"
      t.boolean  "variant_1_active",                    :default => true
      t.boolean  "variant_2_active",                    :default => false
      t.boolean  "variant_3_active",                    :default => false
      t.boolean  "variant_4_active",                    :default => false
    end
  end

end


