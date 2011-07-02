class Shop::ReservationsController < ApplicationController
  load_and_authorize_resource :through => :current_store

  def index
    @reservations = @reservations.ordered
  end

  def create
    @reservation.update_attributes(params[:reservation])
    respond_with @reservation
  end

  def update
    @reservation.update_attributes(params[:reservation])
    respond_with @reservation, :location => reservations_path
  end

  def destroy
    @reservation.destroy
    respond_with @reservation
  end

end
