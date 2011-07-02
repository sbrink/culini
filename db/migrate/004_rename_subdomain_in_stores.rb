class RenameSubdomainInStores < ActiveRecord::Migration
  def self.up
    change_table :stores do |t|
      t.rename :subdomain, :domain
    end
  end

  def self.down
    change_table :stores do |t|
      t.rename :domain, :subdomain
    end
  end
end
