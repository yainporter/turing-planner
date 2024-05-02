class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :events_list


  def show
    events = REDIS.get("events_for_#{date}")
    require 'pry'; binding.pry
    @event_list = JSON.parse(events, symbolize_names: true)
  end

  private
# c556003a6bfedddd98ed4f9663c94bd3
end
