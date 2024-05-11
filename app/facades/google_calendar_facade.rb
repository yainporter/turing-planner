class GoogleCalendarFacade
  attr_reader :all_calendar_events

  def initialize(days_in_advance = nil)
    @calendar_service = days_in_advance ? GoogleCalendarService.new(days_in_advance) : GoogleCalendarService.new
    @all_calendar_events = Hash.new
  end

  def create_all_calendar_events
    calendar_ids.map do |mod, calendar_id|
      @all_calendar_events[mod] = create_calendar_events(calendar_id).compact
      # Compact is needed to get rid of nil events in the array because of the if statement
    end

    @all_calendar_events
  end

  private

  def create_calendar_events(calendar_id)
    @calendar_service.turing_calendar(calendar_id)[:items].map do |event_data|
      if event_data[:start][:dateTime]
        # if we don't check for the presence of [:dateTime], then the calendar event is not a daily event, but a weekly one
        CalendarEvent.new(event_data)
      end
    end
  end

  def calendar_ids
    {
      "Community Calendar": "casimircreative.com_ronr9dk92ndvlhsk03kf8jd2ro@group.calendar.google.com",
      "Mod 1": "casimircreative.com_59k8msrrc2ddhcv787vubvp0s4@group.calendar.google.com",
      "Mod 2": "casimircreative.com_rps2hg1nfqjih4rcl3gl6s4lpk@group.calendar.google.com",
      "Mod 3": "casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com",
      "Mod 4": "casimircreative.com_c1s3vspg5v09vh5cnnh88dn2nc@group.calendar.google.com"
    }
  end
end
