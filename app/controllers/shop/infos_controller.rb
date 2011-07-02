class Shop::InfosController < ApplicationController
  before_filter do
    @store = current_store
  end
  authorize_resource :class => "Store", :except => [:show]

  def update
    @store.update_attributes(params[:store])
    respond_with @store, :location => info_path
  end

end
