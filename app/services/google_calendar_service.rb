class GoogleCalendarService
  def initialize(days_in_advance = 0)
    @days_in_advance = days_in_advance
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |faraday|
      faraday.params["key"] = Rails.application.credentials.dig(:GOOGLE_API_KEY)
      # faraday.params["timeMin"] = (Time.now + @days_in_advance.day).strftime('%Y-%m-%dT05:00:00%z')
      faraday.params["timeMin"] = (Time.now - 17.days).strftime('%Y-%m-%dT05:00:00%z')
      # faraday.params["timeMax"] = (Time.now + @days_in_advance.day).strftime('%Y-%m-%dT23:00:00%z')
      faraday.params["timeMax"] = (Time.now - 17.days).strftime('%Y-%m-%dT23:00:00%z')
      faraday.params["singleEvents"] = true
      faraday.params["orderBy"] = "startTime"
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
      faraday.response :raise_error
    end
  end

  # Let facade pass in calendar_id to find the correct calendar

  def turing_calendar(calendar_id)
    response = conn.get("/calendar/v3/calendars/#{calendar_id}/events?")
    response.body
  end

  # def mod1_calendar
  #   response = conn.get("/calendar/v3/calendars/casimircreative.com_59k8msrrc2ddhcv787vubvp0s4@group.calendar.google.com/events?")
  #   response.body
  # end

  # def mod2_calendar
  #   response = conn.get("/calendar/v3/calendars/casimircreative.com_rps2hg1nfqjih4rcl3gl6s4lpk@group.calendar.google.com/events?")
  #   response.body
  # end

  # def mod3_calendar
  #   response = conn.get("/calendar/v3/calendars/casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com/events?")
  #   response.body
  # end

  # def mod4_calendar
  #   response = conn.get("/calendar/v3/calendars/casimircreative.com_c1s3vspg5v09vh5cnnh88dn2nc@group.calendar.google.com/events?")
  #   response.body
  # end

  # def community_calendar
  #   response = conn.get("/calendar/v3/calendars/casimircreative.com_ronr9dk92ndvlhsk03kf8jd2ro@group.calendar.google.com/events?")
  #   response.body
  # end
end
