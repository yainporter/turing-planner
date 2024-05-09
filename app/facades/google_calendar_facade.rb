class GoogleCalendarFacade
  attr_reader :mod

  def initialize(mod, days_in_advance = nil)
    @calendar_service = days_in_advance ? GoogleCalendarService.new(days_in_advance) : GoogleCalendarService.new
    @mod = mod
  end

  def filtered_calendar_events
    create_calendar_events.compact
  end

  private

  def create_calendar_events
    service_data[:items].map do | event_data |
      if event_data[:start][:dateTime]
          CalendarEvent.new(event_data)
      end
    end
  end

  def service_data
    @calendar_service.turing_calendar(calendar_id)
  end

  def calendar_id
    case @mod
    when "Mod 0"
      "casimircreative.com_ronr9dk92ndvlhsk03kf8jd2ro@group.calendar.google.com"
    when "Mod 1"
      "casimircreative.com_59k8msrrc2ddhcv787vubvp0s4@group.calendar.google.com"
    when "Mod 2"
      "casimircreative.com_rps2hg1nfqjih4rcl3gl6s4lpk@group.calendar.google.com"
    when "Mod 3"
      "casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com"
    when "Mod 4"
      "casimircreative.com_c1s3vspg5v09vh5cnnh88dn2nc@group.calendar.google.com"
    else
      "casimircreative.com_ronr9dk92ndvlhsk03kf8jd2ro@group.calendar.google.com"
    end
  end
end
