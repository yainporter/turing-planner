require 'google/apis/calendar_v3'
class WelcomeController < ApplicationController

  def index
    calendar = Google::Apis::CalendarV3
    service = calendar::CalendarService.new
    service.authorization = session[:authorization]
    @calendar_list = service.list_calendar_lists
    require 'pry'; binding.pry
    @calendar_list.items.map do |calendar|
      calendar.summary
    end

    @event_list = service.list_events("casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com")
    # Calendar = Google::Apis::CalendarV3 # Alias the module
    # service = Calendar::CalendarService.new
    # service.authorization = session[:credentials]
    # service.get_calendar("casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com")
  end
end
