class CreateUserAddresses < ActiveRecord::Migration
  def self.up
    create_table :user_addresses, :force => true do |t|
      t.integer :user_id
      t.string   "company"
      t.string   "department"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "street"
      t.string   "postcode"
      t.string   "city"
      t.string   "address_details"
      t.string   "phone"
      t.integer :position
      t.timestamps
    end
    add_index :user_addresses, :user_id
  end

  def self.down
    remove_index :user_addresses, :user_id
    drop_table :user_addresses
  end
end
