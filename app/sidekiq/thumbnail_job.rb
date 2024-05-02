class ThumbnailJob
  include Sidekiq::Job

  def perform(access_token)
    @access_token = access_token
    api_facade = GoogleApiFacade.new({access_token: access_token})
    conn = redis_connection
    event_list = api_facade.create_calendar_events
    conn.write ["SET", "event_list", event_list]
    conn.write ["GET", "event_list"]
    event_list.each.with_index(1) do |event, index|
      event.description[:links_and_text].each do |link_and_text|
        if links_and_text[:url].include?("https://docs.google.com/presentation")
          url =  api_facade.find_thumbnail_url(link_and_text[:drive_id])
          conn.write ["SET", "#{event.id}-#{index}", url]
          conn.write ["GET", "#{event.id}-#{index}"]
        end
      end
    end
  end

  def event_summary
    api_facade = GoogleApiFacade.new({access_token: @access_token})
    event_list = api_facade.create_calendar_events
    events = event_list.map.with_index(1) do |event, index|
      {
        id: event.id,
        summary: event.summary,
        start: event.start,
        index: index
      }

      conn.write ["SET", ]
    end
  end

  def redis_connection
    conn = Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
  end
end
