class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  before_action :events_list

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def events_list
    if current_user
      EventsJob.perform_async(current_user[:mod])
    end
  end

  def load_thumbnail
    if current_user
        ThumbnailJob.perform_async(session[:credentials]["token"])
    end
  end

  def date
    Time.now.strftime("%d/%m/%Y")
  end
end
# app/controllers/users/omniauth_callbacks_controller.rb:
