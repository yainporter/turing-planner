class GoogleOAuthService
  def initialize(refresh_token)
    @payload = {
      "client_id": ENV.FETCH["GOOGLE_CLIENT_ID"],
      "client_secret": ENV.FETCH["GOOGLE_CLIENT_SECRET"],
      "refresh_token": refresh_token,
      "grant_type": "refresh_token"
    }
    @refresh_token = refresh_token
  end

  def conn
    Faraday.new(url: 'https://oauth2.googleapis.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
      faraday.params = @payload
    end
  end

  def refresh_access_token
    conn.post("/token")
  end
end
