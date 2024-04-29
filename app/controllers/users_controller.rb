class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @event_list = calendar_facade.create_calendar_events
  end

  private

  def calendar_facade
    GoogleCalendarFacade.new(current_user[:mod])
  end
end
