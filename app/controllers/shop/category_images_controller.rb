class Shop::CategoryImagesController < ApplicationController
  load_and_authorize_resource

  def index
    @category_image_groups = CategoryImageGroup.ordered.includes(:category_images)
  end

  def create
    @category_image.update_attributes(params[:category_image])
    respond_with @category_image, :location => category_images_path
  end

  def update
    @category_image.update_attributes(params[:category_image])
    respond_with @category_image, :location => category_images_path
  end

  def destroy
    @category_image.destroy
    respond_with @category_image
  end

end
