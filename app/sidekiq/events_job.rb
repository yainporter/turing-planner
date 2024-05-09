class EventsJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform(mod, days_in_advance = nil)
      calendar_facade = if days_in_advance
                          GoogleCalendarFacade.new(mod, days_in_advance)
                        else
                          GoogleCalendarFacade.new(mod)
                        end

      event_list = calendar_facade.filtered_calendar_events
      events = event_list.map.with_index(1) do |event, index|
        {
          id: event.id,
          summary: event.summary,
          start: event.start,
          links_and_text: event.links_and_text,
          formatted_text: event.formatted_text,
          index: index
        }
      end

      events = events.to_json
      store_data(["events_for_#{date}", events])
  end
end
