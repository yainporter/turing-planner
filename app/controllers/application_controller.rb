class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  before_action :check_credentials
  before_action :get_events_list
  # before_action :load_thumbnails
  include DatabaseConnection

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def check_credentials
    unless credentials.nil? || expired?
      set_credentials
    end
  end

  def get_events_list
    EventsTodayJob.perform_async
  end

  def load_thumbnails
    ThumbnailJob.perform_async(credentials, ":Mod 1")
  end

  private

  def set_credentials
    time = DateTime.now
    $redis.set("expiration", time.advance(seconds: 3600))
    google_oauth = GoogleOAuthService.new
    $redis.set("access_token", google_oauth.refresh_access_token)
  end

  def credentials
    $redis.get("access_token")
  end

  def expired?
    $redis.get("expiration") || DateTime.now.to_s >= $redis.get("expiration")
  end
end
