module StoreHelper

  def link_to_add_article(article,variant)
    link_to to_money(article.price(variant)),
      cart_articles_path(:article => { :id => article.id, :variant => variant}),
      :method => :post, :class => "add_article", :remote => true,
      :title => "in den Warenkorb"
  end


  def link_to_category(category,options)
    if options[:current_id] && category.id == options[:current_id]
      link_to category.name, category, :class => "current"
    else
      link_to category.name, category
    end
  end

  def link_to_edit_store(link_text=t('views.store.edit_store'))
    link_to link_text, edit_info_path, :class => (controller_name =="infos")? "current" : nil
  end

  def link_to_edit_design(link_text=t('views.store.edit_design'))
    link_to link_text, design_path, :class => (controller_name =="designs")? "current" : nil
  end

  def link_to_edit_hours(link_text=t('views.store.edit_store_hours'))
    link_to link_text, store_hours_path, :class => (controller_name =="store_hours")? "current" : nil
  end

  def link_to_orders(link_text="Eingegangene Bestellungen")
    link_to link_text, orders_path, :class => (controller_name =="orders")? "current" : nil
  end

  def link_to_reservations(link_text="Reservierungen")
    link_to link_text, reservations_path, :class => (controller_name =="reservations")? "current" : nil
  end

end
