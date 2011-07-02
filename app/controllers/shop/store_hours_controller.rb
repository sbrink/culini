class Shop::StoreHoursController < ApplicationController
  load_and_authorize_resource :through => :current_store

  def index
    @store_hours =  @store_hours.ordered
  end

  def create
    @store_hour.update_attributes(params[:store_hour])
    respond_with @store_hour, :location => store_hours_path
  end

  def update
    @store_hour.update_attributes(params[:store_hour])
    respond_with @store_hour, :location => store_hours_path
  end

  def destroy
    @store_hour.destroy
    respond_with @store_hour
  end

end
