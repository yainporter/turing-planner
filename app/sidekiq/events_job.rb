class EventsJob
  include Sidekiq::Job
  include HiredisConnection

  def perform(mod)
    conn = HiredisConnection.conn
    calendar_facade = GoogleCalendarFacade.new({mod: mod})
    event_list = calendar_facade.create_calendar_events
    events = event_list.map.with_index(1) do |event, index|
      {
        id: event.id,
        summary: event.summary,
        start: event.start,
        description: event.description,
        index: index
      }
    end

    date = Time.now.strftime("%d/%m/%Y")
    events = events.to_json

    conn.write(["SET", "events_for_#{date}", events])
    conn.write(["GET", "events_for_#{date}"])
    conn.read
  end
end
