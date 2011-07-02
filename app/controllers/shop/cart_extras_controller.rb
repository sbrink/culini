class Shop::CartExtrasController < ApplicationController
  load_resource :cart_article, :through => :current_cart
  load_resource :cart_extra, :through => :cart_article

  def create
    @cart_extra = @cart_article.cart_extras.create do |cart_extra|
      cart_extra.extra_id = params[:extra][:id]
    end
  end

  def inc
    @cart_article.increment_quantity!
  end

  def dec
    @cart_article.decrement_quantity!
  end

  def destroy
    @cart_extra.destroy
  end

end
