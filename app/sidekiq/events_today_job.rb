class EventsTodayJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform
    date = Time.now.strftime("%d/%m/%Y")
    events = Hash.new
    calendar_events = all_calendar_events
    calendar_events.each do |mod, calendar_events|
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

    DatabaseConnection.store_data(["calendars", "#{calendar_events.keys.to_json}"])
    
    events.each do |mod, calendar_events|
      DatabaseConnection.store_data(["events_for_#{mod.to_s}_#{date}", calendar_events.to_json])
    end
  end

  private

  def all_calendar_events
    calendar_facade = GoogleCalendarFacade.new
    calendar_facade.create_all_calendar_events
  end
end
