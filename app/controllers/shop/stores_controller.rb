class Shop::StoresController < ApplicationController
  load_and_authorize_resource :through => :current_user

  def create
    @store.update_attributes(params[:page])
    respond_with @store, :location => categories_path(:store_id => @store)
  end

end
