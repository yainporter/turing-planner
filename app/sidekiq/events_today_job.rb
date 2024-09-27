class EventsTodayJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform
    events = Hash.new
    db_connection = DatabaseConnection.new
    all_calendar_events.each do |mod, calendar_events|
      events[mod] = calendar_events.map.with_index(1) do |event, index|
          {
            id: event.id,
            summary: event.summary,
            start: event.start,
            links_and_text: event.links_and_text,
            formatted_text: event.formatted_text,
            index: index
          }
      end
    end
    DatabaseConnection.store_info(events)
  end

  def all_calendar_events
    calendar_facade = GoogleCalendarFacade.new
    calendar_facade.create_all_calendar_events
  end

  def store_info(events_hash)
    events_hash.each do |mod, calendar_events|
      DatabaseConnection.store_data(["events_for_#{mod.to_s}_#{date}", calendar_events.to_json])
    end
  end
end
