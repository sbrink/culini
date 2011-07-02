class AddStoreNotificationOptions < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
       t.boolean :order_enabled, :default => true
       t.boolean :email_notification_enabled, :default => false
       t.string :email_notification_address
       t.boolean :fax_notification_enabled, :default => true
    end
  end

  def self.down
    change_table :stores do |t|
       t.remove :order_enabled
       t.remove :email_notification_enabled
       t.remove :email_notification_address
       t.remove :fax_notification_enabled
    end
  end
end
