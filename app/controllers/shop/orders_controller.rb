class Shop::OrdersController < ApplicationController
  load_and_authorize_resource :through => :current_store
  respond_to :html, :json, :only => :status

  def index
    @orders = @orders.ordered.page(params[:page]).per(20)
  end

  def preview
    render 'mailers/order_mailer/order_confirmation', :layout => nil
  end

end
