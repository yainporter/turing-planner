class ThumbnailJob
  include Sidekiq::Job
  include HiredisConnection

  def perform(access_token)
    calendar_facade = GoogleApiFacade.new({access_token: access_token})
    event_list = calendar_facade.create_calendar_events
    conn.write ["SET", "event_list", event_list]
    conn.write ["GET", "event_list"]
    event_list.each.with_index(1) do |event, index|
      event.description[:links_and_text].each do |link_and_text|
        if links_and_text[:url].include?("https://docs.google.com/presentation")
          url =  calendar_facade.find_thumbnail_url(link_and_text[:drive_id])
          conn.write ["SET", "#{event.id}-#{index}", url]
          conn.write ["GET", "#{event.id}-#{index}"]
        end
      end
    end
  end
end
