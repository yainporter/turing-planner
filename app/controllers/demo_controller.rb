class DemoController < ApplicationController
  def show
    @mod = demo_params[:mod]
    events = REDIS.get("events_for_#{current_user[:mod]}_#{date}")
    if events
      @event_list = JSON.parse(events, symbolize_names: true)
    end
  end

  private

  def demo_params
    params.permit(:mod)
  end
end
