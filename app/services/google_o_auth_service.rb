class GoogleOAuthService
  attr_reader :access_token

  def initialize
    @access_token = get_access_token
  end

  def get_access_token
    access_token = $redis.get(ACCESS_TOKEN)

    if access_token
      access_token
    else
      new_token = refresh_access_token

      set_credentials(access_token)
      new_token
    end
  end

  def set_credentials(access_token)
    expires_in = 3500
    $redis.set(ACCESS_TOKEN, access_token, ex: expires_in)
  end

  def refresh_access_token
    credentials = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('turing-planner-73e2d7998a61.json'),
      scope: [
        'https://www.googleapis.com/auth/calendar',
        "https://www.googleapis.com/auth/presentations.readonly"
      ]
    )

    credentials.fetch_access_token!['access_token']
  end
end
