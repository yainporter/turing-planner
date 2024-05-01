class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    super
  end

  def google_oauth2
    auth_hash = request.env['omniauth.auth']
    session[:credentials] = auth_hash[:credentials]
    @user = User.from_omniauth(auth_hash)
    if @user.persisted?
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

  def client_options
    {
      client_id: Rails.application.credentials.dig(:GOOGLE_CLIENT_ID, :key),
      client_secret: Rails.application.credentials.dig(:GOOGLE_CLIENT_SECRET, :key),
      authorization_uri: "https://accounts.google.com/o/oauth2/auth",
      token_credential_uri: "https://oauth2.googleapis.com/token",
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: "http://localhost:3000/users/auth/google_oauth2/callback"
    }
  end
end
