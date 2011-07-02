class Shop::CheckoutsController < ApplicationController
  respond_to :json, :only => :search

  def show
    @order = Order.new(session[:order])
    render 'empty' if current_cart.empty?
  end

  def create
    return render 'empty' if current_cart.empty?
    session[:order] = params[:order]
    @order = current_store.orders.build(session[:order]) do |order|
      order.cart_id    = current_cart.id
      order.ip_address = request.remote_ip
    end
    if @order.save
      redirect_to [:status,@order]
    else
      render "show"
    end
  end

  def search
    @zone = Zone.where(["postcode =?",params[:postcode]]).first
    respond_with(@zone)
  end

end
