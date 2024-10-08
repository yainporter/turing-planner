class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    super
  end

  def google_oauth2
    @user = User.from_omniauth(auth_hash)
    if @user.persisted?
      store_session_info
      sleep 5.seconds
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'

      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def after_omniauth_failure_path_for(scope)
    super(scope)
  end

  private

  def user_email
    auth_hash[:info][:email]
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def store_session_info
    unless session[:email]
      session[:email] = user_email
      credentials = {
      token: auth_hash[:credentials][:token],
      refresh_token: auth_hash[:credentials][:refresh_token]
      }
      credentials = credentials.to_json
      $redis.set(user_email, credentials)
    end
  end
end
