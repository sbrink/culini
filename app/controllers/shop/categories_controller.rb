class Shop::CategoriesController < ApplicationController
  load_and_authorize_resource :through => :current_store
  respond_to :html, :json, :only => [:index, :show]

  def index
    return if can?(:edit,@category)
    @category = current_store.categories.ordered.roots.first
    render "show"
  end

  def new
    @category = current_store.categories.build
  end

  def first
    return if can?(:edit,@category)
    @category = current_store.categories.ordered.roots.first
    render "show"
  end

  def show
    redirect_to @category.parent if @category.parent
  end

  def create
    @category = current_store.categories.create(params[:category])
  end

  def update
    @category.update_attributes(params[:category])
  end

  def destroy
    @category.destroy
    redirect_to @category.root
  end

  def sort
    current_store.categories.reorder(params[:category])
    render :nothing => true
  end

end
