class Shop::ThemesController < ApplicationController
  load_and_authorize_resource

  def index
    @themes = @themes.ordered
  end

  def create
    @theme.update_attributes(params[:theme])
    respond_with @theme, :location => themes_path
  end

  def update
    @theme.update_attributes(params[:theme])
    respond_with @theme, :location => themes_path
  end

  def destroy
    @theme.destroy
    respond_with @theme
  end

end
