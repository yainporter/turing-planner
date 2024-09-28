class GoogleOAuthService
  attr_reader :credentials
  
  def initialize
    @credentials = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('turing-planner-73e2d7998a61.json'),
      scope: [
        'https://www.googleapis.com/auth/calendar'
      ]
    )
  end

  def refresh_access_token
    @credentials.fetch_access_token!['access_token']
  end
end
