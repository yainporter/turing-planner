class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  before_action :check_credentials
  before_action :get_events_list
  before_action :load_thumbnails
  include DatabaseConnection

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def check_credentials
    return unless credentials.nil?

    GoogleOAuthService.new
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

  def credentials
    $redis.get(ACCESS_TOKEN)
  end
end
