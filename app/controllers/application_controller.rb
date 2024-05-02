class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def api_facade
    GoogleApiFacade.new({mod: current_user[:mod], access_token: session[:credentials]["token"], refresh_token: session[:credentials]["refresh_token"]})
  end

  def event_list
    api_facade.create_calendar_events
  end

  def load_thumbnail
    if current_user
        ThumbnailJob.perform_async(session[:credentials]["token"])
    end
  end

  def redis_connection
    conn = Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
  end
end
# app/controllers/users/omniauth_callbacks_controller.rb:
