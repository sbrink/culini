class AddReservationToStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :reservations_enabled, :boolean, :default => false
  end

  def self.down
    remove_column :stores, :reservations_enabled
  end
end
