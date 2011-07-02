class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_apps
    @user = User.find_for_openid(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.gmail_data"] = 'env["omniauth.auth"]'
      redirect_to new_user_registration_url
    end
    #render :text => env["omniauth.auth"]
    #render :text => @user
  end
end
