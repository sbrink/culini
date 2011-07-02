class Shop::DesignsController < ApplicationController
  before_filter do
    @store = current_store
  end
  authorize_resource :class => "Store"

  def update
    @store.attributes = params[:store]
    @store.header = nil if params[:store][:delete_header] == "1"
    @store.save
    respond_with @store, :location => design_path
  end

  def screen
    st = render_to_string("app/stylesheets/themes/#{@store.theme.stylesheet}.sass", :layout => nil)
    render :text => Sass::Engine.new(st, :syntax => :sass, :full_exception => true, :load_paths => ["#{Rails.root}/app/stylesheets"]).render
  end

end
