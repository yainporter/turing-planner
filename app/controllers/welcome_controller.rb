class WelcomeController < ApplicationController

  def index
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = (session[:authorization])
    @calendar_list = service.list_calendar_lists

    @event_list = service.list_events("casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com")
  end
end
