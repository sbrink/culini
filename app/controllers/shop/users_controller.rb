class Shop::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.where('email like ?',"%"+params[:q]+"%") if params[:q] && !params[:q].blank?
    @users = @users.order("created_at desc").page(params[:page]).per(40 )
  end

end
