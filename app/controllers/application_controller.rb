class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  before_action :load_events_list
  before_action :load_thumbnails
  include DatabaseConnection

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def load_events_list
    if current_user && events_list.nil?
      EventsJob.perform_async(current_user[:mod])
      EventsJob.perform_async(current_user[:mod], 1)
    end
  end

  def credentials
    credentials = REDIS.get(session[:email])
    JSON.parse(credentials, symbolize_names: true)
  end

  def load_thumbnails
    if current_user && events_list != nil
        ThumbnailJob.perform_async(credentials[:token])
    end
  end
end
