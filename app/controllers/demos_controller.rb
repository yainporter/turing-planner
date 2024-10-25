class DemosController < ApplicationController
  def show
    mod = demo_params[:mod]
    today = Time.now.strftime("%d/%m/%Y")
    events = $redis.get("events_for_#{mod}_#{today}")
    if events
      @event_list = JSON.parse(events, symbolize_names: true)
    end
  end

  private

  def demo_params
    params.permit(:mod)
  end
end
