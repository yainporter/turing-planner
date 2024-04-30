class GoogleSlidesService

  def initialize(access_token)
    @access_token = access_token
  end

  def conn
    Faraday.new(url: 'https://slides.googleapis.com') do |faraday|
      faraday.request :authorization, "Bearer", -> { @access_token }
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
    end
  end

  def get_presentation(presentation_id)
    response = conn.get("/v1/presentations/#{presentation_id}")
    response.body
  end
end
