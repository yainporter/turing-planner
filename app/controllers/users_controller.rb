class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @api_facade = api_facade
    @event_list = api_facade.create_calendar_events
  end

  private
end
