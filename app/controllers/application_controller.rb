class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
# app/controllers/users/omniauth_callbacks_controller.rb:
