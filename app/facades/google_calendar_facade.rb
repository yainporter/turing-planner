class GoogleCalendarFacade
  attr_reader :calendar_id

  def initialize(calendar_id)
    @service = GoogleCalendarService
    @calendar_id = calendar_id
  end

  def service_data
    @service.turing_calendar(calendar_id)
  end

  def create_calendar_events
    service_data[:items].map do | event_data |
      Event.create(@calendar_id)
    end
  end
end
#module? #separate methods for each one?
