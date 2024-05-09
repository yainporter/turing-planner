class GoogleService
  attr_reader :refresh_token
  def initialize(refresh_token)
    @refresh_token = refresh_token
  end

  def conn
    Faraday.new(url: 'https://oauth2.googleapis.com') do |faraday|
      faraday.body["client_id"] = Rails.application.credentials.dig(:GOOGLE_API_KEY)
      faraday.body["client_secret"] = Rails.application.credentials.dig(:GOOGLE_API_KEY)
      faraday.body["refresh_token"] = refresh_token
      faraday.body["grant_type"] = "refresh_token"
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
    end
  end

  def refresh_token
    conn.post("/token")
  end
end
