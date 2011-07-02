class OrderMailer < ActionMailer::Base
  helper :application
  default :from => "orders@culini.de"

  def order_confirmation(order)
    @order = order
    #attachments['culini_logo.png'] = File.read("#{Rails.root}/public/images/culini_logo.png")
    mail :to => @order.email, :subject => "Bestellbestaetigung - #{@order.store.name}"
  end

  def order_instruction(order)
    @order = order
    mail :to => @order.store.email_notification_address, :subject => "Bestellauftrag - #{@order.full_name}"
  end

  def order_failed(order)
    @order = order
    mail :to => @order.email, :subject => "Bestellung bei #{@order.store.name} fehlgeschlagen"
  end

end
