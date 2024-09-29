class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_events_list
  before_action :load_thumbnails
  include DatabaseConnection
  include GoogleCredentials

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def get_events_list
    EventsTodayJob.perform_async
  end

  def load_thumbnails
    return unless $redis.get("calendars")

    calendars = JSON.parse($redis.get("calendars"))
    calendars.each do |calendar|
      ThumbnailJob.perform_async(calendar)
    end
  end

  private


end
