class AddOrderStatusAttributes < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
       t.integer :status_id, :default => 0, :limit => 6, :null => false
       t.string  :fax_id, :limit => 16
    end
  end

  def self.down
    change_table :orders do |t|
       t.remove :status_id
       t.remove :fax_id
    end
  end
end
