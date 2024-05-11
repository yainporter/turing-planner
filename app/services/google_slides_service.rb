class GoogleSlidesService

  def initialize(data)
    @access_token = data[:access_token]
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
