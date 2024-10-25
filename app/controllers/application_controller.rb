class ApplicationController < ActionController::Base
  include GoogleCredentials

  protect_from_forgery with: :exception
  before_action :get_access_token
  before_action :get_events_list
  before_action :load_thumbnails

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def get_events_list
    return unless $redis.get(ACCESS_TOKEN)
    EventsTodayJob.perform_async
  end

  def load_thumbnails
    return unless $redis.get(ACCESS_TOKEN)
    return unless $redis.get("calendars")

    calendars = JSON.parse($redis.get("calendars"))
    calendars.each do |calendar|
      ThumbnailJob.perform_async(calendar)
    end
  end

  private
end
