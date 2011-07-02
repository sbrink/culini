class AddCodeToOrder < ActiveRecord::Migration
  def self.up
    change_table :order_articles do |t|
      t.string   "code",            :limit => 13,                               :default => ""
    end

    change_table :order_extras do |t|
      t.string   "code",            :limit => 13,                               :default => ""
    end
  end

  def self.down
    change_table :order_articles do |t|
      t.remove "code"
    end

    change_table :order_extras do |t|
      t.remove "code"
    end
  end
end
