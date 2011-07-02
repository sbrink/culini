class Shop::ExtrasController < ApplicationController
  load_and_authorize_resource :category, :through => :current_store
  load_and_authorize_resource :extra, :through => :category
  respond_to :html, :json, :js

  def new
    @extra = @category.extras.new_with_guess_extra_code
  end

  def index
    @extras = @category.extras
  end

  def create
    @extra = @category.extras.create(params[:extra])
  end

  def update
    @extra.update_attributes(params[:extra])
  end

  def destroy
    @extra.destroy
  end

end
