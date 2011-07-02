class Shop::CartsController < ApplicationController

  def show
    @cart = current_cart
    #fresh_when(:etag => @cart, :last_modified => @cart.updated_at.utc)
  end

  def destroy
    current_cart.destroy
    respond_with current_cart, :location => root_url
  end

end
