class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  # before_action :load_events_list
  # before_action :load_thumbnails
  include DatabaseConnection

  def after_sign_in_path_for(resource)
    loading_path
  end

  def load_events_list
    if current_user && events_list.nil?
      EventsJob.perform_async(current_user[:mod])
    end
  end

  # def load_thumbnails
  #   if current_user && session[:drive_id].nil? && events_list.present?
  #     credentials = REDIS.get(session[:email])
  #     credentials = JSON.parse(credentials, symbolize_names: true)
  #     ThumbnailJob.perform_async(credentials[:token])
  #     sleep 30.seconds
  #   end
  # end

  def credentials
    credentials = REDIS.get(session[:email])
    JSON.parse(credentials, symbolize_names: true)
  end
end
# app/controllers/users/omniauth_callbacks_controller.rb:
