class ApplicationController < ActionController::Base
  protect_from_forgery
  responders :flash
  respond_to :html
  layout proc { |c| c.request.xhr? ? false : (current_store ? "store" : "portal") }


  protected

  def user_root_path
    stored_location_for(:user) || root_path
  end

  def default_url_options(options={})
    { :store_id => (params[:store_id] ? params[:store_id] : nil) }
  end

  helper_method :current_store
  def current_store
    @_current_store ||= params[:store_id]? Store.find(params[:store_id]) : Store.find_by_domain(request.host)
  end

  helper_method :current_cart
  def current_cart
    @_current_cart ||= current_store.carts.fresh.find_by_id(session[:cart_id]) || current_store.carts.create
    session[:cart_id] = @_current_cart.id
    @_current_cart
  end

  helper_method :culini_url
  def culini_url(subdomain=nil)
    "http://#{subdomain ? "#{subdomain}." : ""}#{request.domain}"
  end

  helper_method :user_is_admin?
  def user_is_admin?
    user_signed_in? && (current_user.is_superadmin? || (current_user == current_store.user))
  end

  protected

  #rescue_from CanCan::AccessDenied do |exception|
  #  redirect_to new_user_session_path
  #end

end
