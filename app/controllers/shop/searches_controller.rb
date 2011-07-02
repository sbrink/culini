class Shop::SearchesController < ApplicationController
  respond_to :json

  def show
    if params[:last].present?
      @stores = Store.order('created_at').limit(params[:last])
      render 'result'
    elsif params[:q].present?
      @zones = Zone.search(params[:q])
      @zone_ids = @zones.map(&:id)
      @stores = Store.in_zones(@zone_ids)
      @stores = @stores.with_reservations_enabled if params[:reservation] == "true"
      render 'result'
    end
  end

  def autocomplete
    respond_with(Zone.autocomplete(params[:q]))
  end

end
