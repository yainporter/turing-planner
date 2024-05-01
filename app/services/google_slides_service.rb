class GoogleSlidesService

  def initialize(data)
    @access_token = data[:access_token]
    @refresh_token = data[:refresh_token]
    @presentation_id = data[:presentation_id]
  end

  def conn
    Faraday.new(url: 'https://slides.googleapis.com') do |faraday|
      faraday.request :authorization, "Bearer", -> { @access_token }
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
    end
  end

  def oauth_conn
    Faraday.new(url: "https://oauth2.googleapis.com") do |faraday|
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
    end
  end

  def refresh_token

    oauth_conn.post("/token?client_id=#{Rails.application.credentials[:GOOGLE_CLIENT_ID]}&client_secret=#{Rails.application.credentials[:GOOGLE_CLIENT_SECRET]}&refresh_token=#{@refresh_token}&grant_type=refresh_token")
  end

  def get_presentation
    begin
      response = conn.get("/v1/presentations/#{@presentation_id}")
      response.body
    rescue Faraday::UnauthorizedError => e
      puts e.message
    end
  end

  def get_slide_thumbnail(thumbnail_id)
    # attempts = 0
    # max_retries = 5
    # begin
      response = conn.get("/v1/presentations/#{@presentation_id}/pages/#{thumbnail_id}/thumbnail")
      response.body

    # rescue Faraday::TooManyRequestsError
    #   attempts += 1
    #   if attempts <= max_retries
    #     sleep(attempts + Random.rand(1000).in_milliseconds)  # Exponential backoff
    #     retry
    #   else
    #     raise "Failed after #{max_retries} attempts."
    #   end
    # rescue Faraday::Error => e
    #   # Handle other Faraday/HTTP errors
    #   puts "HTTP request failed: #{e.message}"
    # end
  end
end
