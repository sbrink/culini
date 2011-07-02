# delivery_zone
# store_hour
# order
# order_article
# search
# theme_style
# zone

Factory.define :page do |f|
  f.permalink "about"
  f.name "About"
  f.body "Here is all about us"
end

Factory.define :user do |f|
  f.sequence(:email) {|n| "user#{n}@example.com" }
  f.password "secret"
  f.password_confirmation {|a| a.password }
  f.terms_of_service "1"
end

Factory.define :tag do |f|
  f.sequence(:name) { |n| "Tag-#{n}" }
end

Factory.define :store do |f|
  f.name     "Pizzeria Demo"
  f.owner    "Ralph Pizza"
  f.street   "Halterner Str. 140b"
  f.postcode "45657"
  f.city     "Recklinghausen"
  f.association :user
end

Factory.define :category do |f|
  f.name "Pizza"
  f.association :store
end

Factory.define :article do |f|
  f.name "Pizza Tonno"
  f.association :category
end

Factory.define :extra do |f|
  f.name "Oregano"
  f.association :category
end

Factory.define :cart do |f|
  f.association :store
end

Factory.define :cart_article do |f|
  f.association :cart
  f.association :article
end

Factory.define :cart_extra do |f|
  f.association :cart_article
  f.association :extra
end

Factory.define :order do |f|
  f.first_name "John"
  f.last_name  "Doe"
  f.street     "Halterner Str. 33"
  f.postcode   "45657"
  f.city       "Recklinghausen"
  f.phone_area_code    "0170"
  f.phone_local_number "8883737"
  f.ip_address "127.0.0.1"
  f.cart_id { Factory(:cart).id }
  f.association :cart
  f.association :store
end