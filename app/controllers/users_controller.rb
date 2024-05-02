class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    require 'pry'; binding.pry
    @api_facade = api_facade
    @event_list = api_facade.create_calendar_events
  end

  private
end
c556003a6bfedddd98ed4f9663c94bd3
