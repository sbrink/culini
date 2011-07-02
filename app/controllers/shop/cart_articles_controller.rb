class Shop::CartArticlesController < ApplicationController
  load_resource :through => :current_cart

  def create
    @cart_article = current_cart.cart_articles.create do |cart_article|
      cart_article.article_id = params[:article][:id]
      cart_article.variant    = params[:article][:variant]
    end
  end

  def inc
    @cart_article.increment_quantity!
  end

  def dec
    @cart_article.decrement_quantity!
  end

  def cycle
    @cart_article.cycle_variant!
  end

  def destroy
    @cart_article.destroy
  end

end
