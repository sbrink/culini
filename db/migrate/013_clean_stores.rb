class CleanStores < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
       t.remove :custom_css
       t.remove :theme_style
    end
  end

  def self.down
    change_table :stores do |t|
      t.text     "custom_css"
      t.text     "theme_style"
    end
  end

end


