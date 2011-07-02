class InitialSchema < ActiveRecord::Migration
  def self.up
    # We're resetting the migrations database...
    drop_table :schema_migrations
    initialize_schema_migrations_table

  #
  #


    create_table "articles", :force => true do |t|
      t.string   "code",            :limit => 13,                               :default => ""
      t.string   "name",            :limit => 64,                               :default => "",  :null => false
      t.text     "description"
      t.integer  "category_id",  :null => false
      t.integer  "position",        :limit => 8
      t.decimal  "variant_1_price",               :precision => 8, :scale => 2
      t.decimal  "variant_2_price",               :precision => 8, :scale => 2
      t.decimal  "variant_4_price",               :precision => 8, :scale => 2
      t.decimal  "variant_3_price",               :precision => 8, :scale => 2
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "articles", ["category_id"], :name => "index_articles_on_category_id"

    create_table "cart_articles", :force => true do |t|
      t.text     "special_instructions"
      t.integer  "quantity",             :default => 1, :null => false
      t.integer  "cart_id",                             :null => false
      t.integer  "article_id",                          :null => false
      t.integer  "variant",              :default => 1, :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cart_articles", ["cart_id"], :name => "index_cart_articles_on_cart_id"
    add_index "cart_articles", ["article_id"], :name => "index_cart_articles_on_article_id"

    create_table "cart_extras", :force => true do |t|
      t.integer  "cart_article_id",                             :null => false
      t.integer  "extra_id",                          :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "cart_extras", ["cart_article_id"], :name => "index_cart_articles_on_cart_article_id"
    add_index "cart_extras", ["extra_id"], :name => "index_cart_articles_on_extra_id"


    create_table "carts", :force => true do |t|
      t.integer  "store_id",  :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "carts", ["store_id"], :name => "index_carts_on_store_id"

    create_table "categories", :force => true do |t|
      t.string   "name",                  :limit => 40, :default => "",   :null => false
      t.string   "description"
      t.integer  "store_id",  :null => false
      t.integer  "parent_id"
      t.integer  "position",              :limit => 8
      t.boolean  "relevant_to_delivery_costs", :default => true
      t.string   "variant_1_description"
      t.string   "variant_2_description"
      t.string   "variant_3_description"
      t.string   "variant_4_description"
      t.string   "variant_1_name"
      t.string   "variant_2_name"
      t.string   "variant_3_name"
      t.string   "variant_4_name"
      t.boolean  "variant_1_active",                    :default => true
      t.boolean  "variant_2_active",                    :default => false
      t.boolean  "variant_3_active",                    :default => false
      t.boolean  "variant_4_active",                    :default => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
    add_index "categories", ["store_id"], :name => "index_categories_on_store_id"

    create_table "delayed_jobs", :force => true do |t|
      t.integer  "priority", :default => 0
      t.integer  "attempts", :default => 0
      t.text     "handler"
      t.text     "last_error"
      t.datetime "run_at"
      t.datetime "locked_at"
      t.datetime "failed_at"
      t.string   "locked_by"
      t.timestamps
    end

    add_index :delayed_jobs, [:priority, :run_at], :name => 'delayed_jobs_priority'

    create_table "delivery_zones", :force => true do |t|
      t.boolean  "active",                                   :default => true, :null => false
      t.integer  "store_id",                                                   :null => false
      t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0,  :null => false
      t.decimal  "distance",      :precision => 8, :scale => 2, :default => 0.0,  :null => false
      t.integer  "zone_id",                                                    :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "delivery_zones", ["store_id"], :name => "index_delivery_zones_on_store_id"
    add_index "delivery_zones", ["zone_id"], :name => "index_delivery_zones_on_zone_id"

    create_table "extras", :force => true do |t|
      t.string   "code",            :limit => 13,                               :default => ""
      t.string   "name",            :limit => 64,                               :default => "",  :null => false
      t.text     "description"
      t.integer  "category_id", :null => false
      t.integer  "position",        :limit => 8
      t.decimal  "variant_1_price",               :precision => 8, :scale => 2
      t.decimal  "variant_2_price",               :precision => 8, :scale => 2
      t.decimal  "variant_4_price",               :precision => 8, :scale => 2
      t.decimal  "variant_3_price",               :precision => 8, :scale => 2
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "extras", ["category_id"], :name => "index_extras_on_category_id"

    create_table "store_hours", :force => true do |t|
      t.boolean "monday", :default => 1, :null => false
      t.boolean "tuesday", :default => 1, :null => false
      t.boolean "wednesday", :default => 1, :null => false
      t.boolean "thursday", :default => 1, :null => false
      t.boolean "friday", :default => 1, :null => false
      t.boolean "saturday", :default => 1, :null => false
      t.boolean "sunday", :default => 1, :null => false
      t.boolean "holiday", :default => 1, :null => false
      t.integer "store_id", :null => false
      t.time    "opening_from", :null => false, :default => "11:00"
      t.time    "opening_till", :null => false, :default => "11:00"
      t.time    "reservation_from", :default => "11:00"
      t.time    "reservation_till", :default => "11:00"
      t.integer "max_guests_per_booking", :default => 6, :null => false
      t.integer "max_guests",             :default => 6, :null => false
    end
    add_index "store_hours", ["store_id"], :name => "index_store_hours_on_store_id"

    create_table "order_articles", :force => true do |t|
      t.integer  "quantity",                                   :default => 1, :null => false
      t.string   "name",                                                      :null => false
      t.decimal  "price",        :precision => 8, :scale => 2,                :null => false
      t.decimal  "total_price",  :precision => 8, :scale => 2,                :null => false
      t.integer  "order_id",                                                  :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "order_articles", ["order_id"], :name => "index_order_article_on_order_id"

    create_table "order_extras", :force => true do |t|
      t.integer  "quantity",                                   :default => 1, :null => false
      t.string   "name",                                                      :null => false
      t.decimal  "price",        :precision => 8, :scale => 2,                :null => false
      t.decimal  "total_price",  :precision => 8, :scale => 2,                :null => false
      t.integer  "order_article_id",                                          :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "order_extras", ["order_article_id"], :name => "index_order_article_on_order_article_id"

    create_table "orders", :force => true do |t|
      t.string   "company"
      t.string   "department"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "street"
      t.string   "postcode"
      t.string   "city"
      t.string   "address_details"
      t.string   "phone"
      t.string   "email"
      t.integer  "store_id"
      t.integer  "tax_amount",                         :default => 0, :null => false
      t.integer  "total_price",                        :default => 0, :null => false
      t.string   "ip_address"
      t.text     "special_instructions"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "orders", ["store_id"], :name => "index_orders_on_store_id"

    create_table "pages", :force => true do |t|
      t.string   "name"
      t.string   "permalink"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "reservations", :force => true do |t|
      t.integer  "number_of_guests", :null => false, :default => 2
      t.string   "first_name", :null => false
      t.string   "last_name", :null => false
      t.string   "phone", :null => false
      t.string   "email", :null => false

      t.integer  "number_of_guests", :null => false

      t.integer  "store_id", :null => false
      t.integer  "user_id"

      t.date "booked_on", :null => false
      t.time "booked_from", :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
    end



    create_table "searches", :force => true do |t|
      t.boolean  "advanced_search"
      t.string   "q"
      t.string   "postcode",        :limit => 5
      t.string   "city",            :limit => 64
      t.string   "area",            :limit => 64
      t.string   "keywords"
      t.string   "tags"
      t.datetime "created_at"
    end

    create_table "stores", :force => true do |t|
      t.string   "name",                  :limit => 64
      t.string   "owner",                 :limit => 64
      t.string   "street",                :limit => 96
      t.string   "postcode",              :limit => 8
      t.string   "city",                  :limit => 64
      t.string   "phone",                 :limit => 32
      t.string   "fax",                   :limit => 32
      t.string   "tax_number",            :limit => 16
      t.string   "supervisory_authority", :limit => 96
      t.text     "custom_css"
      t.text     "theme_style"
      t.decimal  "lat",                                 :precision => 15, :scale => 10
      t.decimal  "lng",                                 :precision => 15, :scale => 10
      t.decimal  "delivery_radius",                     :precision => 4,  :scale => 2, :default => 3
      t.decimal  "minimum_order_value",                 :precision => 4,  :scale => 2
      t.boolean  "public_access",                                                       :default => true
      t.datetime "header_updated_at"
      t.integer  "header_file_size"
      t.string   "header_content_type"
      t.string   "header_file_name"
      t.integer  "user_id", :null => false
      t.string   "subdomain",             :limit => 32
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "deleted_at"
    end

    add_index "stores", ["user_id"], :name => "index_stores_on_user_id"
    add_index "stores", ["subdomain"], :name => "index_stores_on_subdomain"

    create_table "stores_tags", :id => false, :force => true do |t|
      t.integer "tag_id"
      t.integer "store_id"
    end

    add_index "stores_tags", ["tag_id"], :name => "index_stores_tags_on_tag_id"
    add_index "stores_tags", ["store_id"], :name => "index_stores_tags_on_store_id"

    create_table "tags", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "theme_styles", :force => true do |t|
      t.boolean   "preview",       :default => false
      t.string   "name",        :null => false
      t.string   "dom_element", :null => false
      t.string   "style",       :null => false
      t.integer  "position"
      t.string   "value_1",     :null => false
      t.string   "value_2"
      t.string   "value_3"
      t.string   "value_4"
      t.string   "value_5"
      t.string   "value_6"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "email",                               :default => "", :null => false
      t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
      t.string   "password_salt",                       :default => "", :null => false
      t.boolean  "is_superadmin",                       :default => false
      t.string   "reset_password_token"
      t.string   "remember_token"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",                       :default => 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

    create_table "zones", :force => true do |t|
      t.string   "country",    :limit => 5
      t.string   "postcode",   :limit => 8
      t.string   "city",       :limit => 64
      t.string   "area",       :limit => 64
      t.string   "region1",    :limit => 64
      t.string   "region2",    :limit => 64
      t.string   "region3",    :limit => 64
      t.decimal  "lat",                      :precision => 15, :scale => 10
      t.decimal  "lng",                      :precision => 15, :scale => 10
      t.string   "city_param", :limit => 64
      t.string   "area_param", :limit => 64
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "zones", ["area_param"], :name => "index_zones_on_area_param"
    add_index "zones", ["city"], :name => "index_zones_on_city"
    add_index "zones", ["city_param"], :name => "index_zones_on_city_param"
    add_index "zones", ["postcode"], :name => "index_zones_on_postcode"

  end

  def self.down
    drop_table :articles
    drop_table :cart_articles
    drop_table :cart_extras
    drop_table :carts
    drop_table :categories
    drop_table :delayed_jobs
    drop_table :delivery_zones
    drop_table :extras
    drop_table :order_articles
    drop_table :order_extras
    drop_table :orders
    drop_table :pages
    drop_table :reservations
    drop_table :searches
    drop_table :store_hours
    drop_table :stores
    drop_table :stores_tags
    drop_table :tags
    drop_table :theme_styles
    drop_table :users
    drop_table :zones
  end
end
