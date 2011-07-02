class ChangeOrdersTotalPriceType < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
       t.change "total_price", :decimal, :precision => 8, :scale => 2, :null => false
    end
  end

  def self.down
    # no use for that
  end
end
