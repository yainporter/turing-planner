class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to dashboard_path
  end

  def show
    events = REDIS.get("events_for_#{date}")
    @event_list = JSON.parse(events, symbolize_names: true)
  end

  private
# c556003a6bfedddd98ed4f9663c94bd3
end
