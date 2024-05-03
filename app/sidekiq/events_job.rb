class EventsJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform(mod)
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

      events = events.to_json
      store_data(["events_for_#{date}", events])
  end
end
