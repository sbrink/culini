class Shop::UserAddressesController < ApplicationController
  load_and_authorize_resource :through => :current_user

  def index
    @user_addresses = @user_addresses.ordered
  end

  def create
    @user_address.update_attributes(params[:user_address])
    respond_with @user_address, :location => user_addresses_path
  end

  def update
    @user_address.update_attributes(params[:user_address])
    respond_with @user_address, :location => user_addresses_path
  end

  def destroy
    @user_address.destroy
    respond_with @user_address
  end

  def set_as_default
    @user_address.move_to_top
    respond_with @user_address, :location => user_addresses_path
  end

end
