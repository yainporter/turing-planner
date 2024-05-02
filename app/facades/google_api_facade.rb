class GoogleApiFacade
  attr_reader :mod

  def initialize(hash)
    @calendar_service = GoogleCalendarService
    @mod = hash[:mod]
  end

  def create_calendar_events
    service_data[:items].map do | event_data |
      Event.new(event_data)
    end
  end

  private

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
