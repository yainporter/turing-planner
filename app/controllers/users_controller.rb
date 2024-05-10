class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  def show
    require 'pry'; binding.pry
    events = REDIS.get("events_for_#{date}")
    @event_list = JSON.parse(events, symbolize_names: true)
  end
end
