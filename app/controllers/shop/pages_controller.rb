class Shop::PagesController < ApplicationController
  load_and_authorize_resource :find_by => :handle

  def index
    @pages = @pages.ordered
  end

  def create
    @page.update_attributes(params[:page])
    respond_with @page, :location => page_path(@page.handle)
  end

  def update
    @page.update_attributes(params[:page])
    respond_with @page, :location => page_path(@page.handle)
  end

  def destroy
    @page.destroy
    respond_with @page
  end

end
