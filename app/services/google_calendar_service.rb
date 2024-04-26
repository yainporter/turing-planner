class GoogleCalendarService
  def self.conn
    Faraday.new(url: 'https://www.googleapis.com') do |faraday|
      faraday.params["key"] = Rails.application.credentials.dig(:GOOGLE_API_KEY)
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
    end
  end

  def self.mod_1_calendar
    response = conn.get("/calendar/v3/calendars/casimircreative.com_59k8msrrc2ddhcv787vubvp0s4@group.calendar.google.com/events?")
    require 'pry'; binding.pry
    response.body
  end
end
