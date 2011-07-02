#require 'interfax'
class Shop::FaxesController < ApplicationController

  def index
    authorize! :manage, Shop
    @fax_items = OrderFax.all()
  end

  def new
   authorize! :manage, Shop
   @order = Order.first
   @p = render_to_string(:partial => 'fax').to_s
  end

   def create
    authorize! :manage, Shop
    @order = Order.find(2)
    @fax = OrderFax.new(:html).contains(render_to_string(:partial => 'fax')).subject(@order.fax_subject).to("+49236189013699")
    @result = @fax.deliver
   end

end
