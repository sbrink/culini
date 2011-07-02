class Shop::ArticlesController < ApplicationController
  load_and_authorize_resource :category, :through => :current_store
  load_and_authorize_resource :article, :through => :category
  respond_to :html, :json, :js

  def show
    respond_with(@article)
  end

  def new
    @article = @category.articles.new_with_guess_article_code
  end

  def create
    @article = @category.articles.create(params[:article])
  end

  def update
    @article.update_attributes(params[:article])
  end

  def destroy
    @article.destroy
  end

  def sort
    @category.articles.reorder(params[:article])
    render :nothing => true
  end

end
