class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, if: -> { Rails.env.test? }

  def show
    today = Time.now.strftime("%d/%m/%Y")
    events = $redis.get("events_for_#{current_user[:mod]}_#{today}")
    if events
      @event_list = JSON.parse(events, symbolize_names: true)
    end
  end
end
