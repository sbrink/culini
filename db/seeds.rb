["Baguette / Croques",
 "Burger",
 "Desserts",
 "Döner",
 "Eis",
 "Fast Food",
 "Fingerfood",
 "Fisch",
 "Fladenbrote",
 "Fleischgerichte",
 "Geflügel",
 "Gratin / Auflauf",
 "Griechisch",
 "Grillspezialitäten",
 "Gyros",
 "Hausmannskost",
 "Indisch",
 "Kartoffelgerichte",
 "Kinder-Menüs",
 "Mittagsangebote",
 "Nudeln / Pasta",
 "Omelettes / Eierspeisen",
 "Party Platten",
 "Pizza",
 "Salate",
 "Snacks",
 "Suppen",
 "Tagesangebote",
 "Türkisch",
 "Vegetarisch",
 "Vorspeisen",
 "Wraps"
].each do |name|
  Tag.find_or_create_by_name(name)
end

User.find_or_create_by_email('sascha.brink@culini.de', :password => "egusto", :password_confirmation => "egusto", :terms_of_service => "1")
User.find_or_create_by_email('uschi.wessels@culini.de', :password => "egusto", :password_confirmation => "egusto", :terms_of_service => "1")


return if Store.all.any?

store = User.first.stores.create(
  :name => "Demo", :owner => "Demo Owner", :subdomain => "demo",
  :street => "Halterner Str. 33",
  :postcode => "45657", :city => "Recklinghausen"
).tap() do |store|
  store.categories.find_or_create_by_name("Pizza")

  [
    ["1", "Pizza Margherita", "mit Tomatensauce, Käse und Oregano", ["3.20", "4.60", "8.20"]],
    ["1A", "Pizza Bolognese", "mit Hackfleischsauce und Käse", ["4.20", "6.20", "10.30"]],
    ["1B", "Pizza Rodeo", "mit Barbecue-Sauce, Zwiebeln, Hackfleisch, Speck und Käse", ["4.90", "6.90", "12.50"]],
    ["1C", "Pizza Poncho", "mit Barbecue-Sauce, Paprika, Zwiebeln, Mais und Hühnerbruststreifen", ["5.90", "8.50", "13.50"]],
    ["1D", "Pizza Jazz", "mit Sauce Hollandaise, Broccoli, Schinken und Käse", ["4.60", "6.90", "12.10"]],
    ["1E", "Pizza Puls", "mit Sauce Hollandaise, Krabben, Blattspinat und Käse", ["4.90", "7.70", "12.70"]],
    ["2", "Pizza Salami oder Schinken", "mit Tomatensauce, Käse und Schinken oder Salami nach Wahl", ["3.70", "5.40", "9.50"]],
    ["3", "Pizza Thunfisch Plus", "mit Tomatensauce, extra Thunfisch, Zwiebeln und extra Käse", ["4.90", "7.40", "12.50"]],
    ["4", "Pizza Hawaii", "mit Tomatensauce, Schinken, Ananas und extra Käse", ["4.20", "6.70", "12.00"]],
    ["5", "Pizza Feinschmecker", "mit Tomatensauce, Schinken, Salami, Champignons und Käse", ["4.40", "6.90", "12.10"]],
    ["6", "Pizza Europa", "mit Tomatensauce, Salami, Paprika, Champignons, Hackfleisch und Käse", ["4.90", "7.70", "12.60"]],
    ["7", "Pizza Vier Jahreszeiten", "mit Tomatensauce, Salami, Schinken, Champignons, Artischocken und Käse", ["4.90", "7.70", "12.60"]],
    ["8", "Pizza Calzone", "mit Tomatensauce, Salami, Schinken, Champignons, Paprika, Quark und Käse", ["4.90", "7.70", "13.10"]],
    ["9", "Pizza Mista", "mit Tomatensauce, Thunfisch, Salami, Schinken, Champignons und Käse", ["4.90", "7.70", "13.10"]],
    ["10", "Pizza Marco", "mit Tomatensauce, Salami, Schinken, Paprika, Zwiebeln, Champignons, Hackfleisch und Käse", ["5.90", "8.50", "13.60"]],
    ["10A", "Pizza Texas", "mit Barbecue-Sauce, Hühnerbrustfilet, Zwiebeln, frischen Champignons und Jalapeno-Pepperscheiben", ["5.90", "8.50", "13.50"]],
    ["10B", "Pizza Western", "mit Barbecue-Sauce, zartem Schinken, Würfelhackfleisch, Speck, Zwiebeln und Mozzarella", ["5.90", "8.50", "13.50"]],
    ["11", "Pizza Marinara", "mit Tomatensauce, Krabben, Calamari, Muscheln und Käse", ["5.60", "7.40", "12.60"]],
    ["12", "Pizza Ravi", "mit Tomatensauce, Schinken, Paprika, frischen Tomaten, frischen Champignons, Hühnerbruststreifen und Käse", ["5.90", "8.50", "13.60"]],
    ["12A", "Pizza Gyros", "mit Tomatensauce, würzigem Gyros, Zwiebeln und Käse", ["4.90", "7.20", "12.30"]],
    ["12B", "Pizza Krabben", "mit Tomatensauce, Krabben, Knoblauch und Käse", ["4.20", "6.20", "10.80"]],
    ["12C", "Pizza Asia", "mit Chili-Sauce, Paprika, Zwiebeln, frischen Champignons, Hackfleisch und Käse", ["4.90", "6.90", "12.50"]],
    ["12D", "Pizza Diavolo", "mit Tomatensauce, Paprika, Zwiebeln, Champignons, Jalapenos-Pepperscheiben und Käse", ["4.90", "6.90", "12.50"]],
    ["12E", "Pizza Caprese", "mit Tomatensauce, Tomatenscheiben, Mozzarella, Basilikum und Käse", ["4.20", "6.20", "10.80"]],
    ["13", "Pizza Florentine", "mit Tomatensauce, Blattspinat, frischen Champignons, Knoblauch und Käse", ["4.40", "6.40", "11.30"]],
    ["14", "Pizza Eden", "mit Tomatensauce, Paprika, Zwiebeln, frischen Champignons, Broccoli und Käse", ["4.90", "7.20", "12.60"]],
    ["15", "Pizza Mama", "mit Tomatensauce, Paprika, Zwiebeln, frischen Champignons, Artischocken, Tomatenscheiben, Peperoni und Käse", ["4.90", "7.40", "12.80"]],
  ].each do |article|
    store.categories.first.articles.create(:code => article[0], :name => article[1], :description => article[2],
      :variant_1_price => article[3][0], :variant_2_price => article[3][1], :variant_3_price => article[3][2])
  end

end






