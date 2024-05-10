class GoogleSlidesService

  def initialize(data)
    @access_token = data[:access_token]
    @refresh_token = data[:refresh_token]
  end

  def conn
    Faraday.new(url: 'https://slides.googleapis.com') do |faraday|
      faraday.request :authorization, "Bearer", -> { @access_token }
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
      faraday.params["key"] = Rails.application.credentials.dig(:GOOGLE_API_KEY)
      faraday.params["timeMin"] = (Time.now + @days_in_advance.day).strftime('%Y-%m-%dT05:00:00%z')
      # faraday.params["timeMin"] = (Time.now - 17.days).strftime('%Y-%m-%dT05:00:00%z')
      faraday.params["timeMax"] = (Time.now + @days_in_advance.day).strftime('%Y-%m-%dT23:00:00%z')
      # faraday.params["timeMax"] = (Time.now - 17.days).strftime('%Y-%m-%dT23:00:00%z')
      faraday.params["singleEvents"] = true
    end
  end

  def refresh_token
    oauth_conn.post("/token?client_id=#{Rails.application.credentials[:GOOGLE_CLIENT_ID]}&client_secret=#{Rails.application.credentials[:GOOGLE_CLIENT_SECRET]}&refresh_token=#{@refresh_token}&grant_type=refresh_token")
  end

  def get_presentation(presentation_id)
    begin
      response = conn.get("/v1/presentations/#{presentation_id}")
      response.body
    rescue Faraday::UnauthorizedError => e
      parse_error_message(e)
    end
  end

  def get_slide_thumbnail(ids)
    presentation_id = ids[:presentation_id]
    thumbnail_id = ids[:thumbnail_id]
    retries = 0
    max_retries = 6
    begin
      response = conn.get("/v1/presentations/#{presentation_id}/pages/#{thumbnail_id}/thumbnail")
      response.body
    rescue Faraday::TooManyRequestsError => e
      if retries <= max_retries
        retries += 1
        sleep 2 ** retries
        retry
      else
        raise "Timeout: #{e.message}"
      end
    end
  end

  private

  def parse_error_message(e)
    JSON.parse(e.response_body, symbolize_names: true)[:error][:message]
  end
end
