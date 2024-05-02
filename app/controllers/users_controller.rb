class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_thumbnail


  def show
    @api_facade = api_facade
    @event_list = api_facade.create_calendar_events
  end

  private
# c556003a6bfedddd98ed4f9663c94bd3
end
