class AuthenticationsController <  Devise::OmniauthCallbacksController

  def all
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.where(provider: omniauth['provider'], uid: omniauth['uid']).take

    if authentication
      flash[:notice] = "Logged in Successfully"
      sign_in_and_redirect User.find(authentication.user_id)
    elsif current_user
      token = omniauth['credentials'].token
      token_secret = omniauth['credentials'].has_key?('secret') ?  omniauth['credentials'].secret : nil

      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => token, :token_secret => token_secret)

      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
    else
      user = User.new
      user.apply_omniauth(omniauth)

      session['devise.omniauth'] = omniauth.except('extra')
      redirect_to new_user_registration_path
    end
  end

  alias_method :facebook, :all

end
