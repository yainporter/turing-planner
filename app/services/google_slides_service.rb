class GoogleSlidesService
  def initialize
    @access_token = access_token
  end

  def conn
    Faraday.new(url: 'https://slides.googleapis.com/') do |conn|
      conn.request :url_encoded
      conn.adapter Faraday.default_adapter
      conn.headers['Authorization'] = "Bearer #{@access_token}"
      conn.headers['Content-Type'] = 'application/json'
    end
  end

  def get_presentation(presentation_id)
    response = conn.get("/v1/presentations/#{presentation_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_slide_thumbnail(ids)
    presentation_id = ids[:presentation_id]
    thumbnail_id = ids[:thumbnail_id]
    retries = 0
    max_retries = 6
    begin
      response = conn.get("/v1/presentations/#{presentation_id}/pages/#{thumbnail_id}/thumbnail")
      JSON.parse(response.body)
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

  def access_token
    google_auth = GoogleOAuthService.new
    google_auth.refresh_access_token
  end

  def parse_error_message(e)
    JSON.parse(e.response_body, symbolize_names: true)[:error][:message]
  end
end
