class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def api_facade
    GoogleApiFacade.new({mod: current_user[:mod], access_token: session[:credentials]["token"], refresh_token: session[:credentials]["refresh_token"]})
  end

  def event_list
    api_facade.create_calendar_events
  end
end
# app/controllers/users/omniauth_callbacks_controller.rb:
