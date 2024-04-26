class ApplicationController < ActionController::Base
  before_action :authenticate_user!

end
# app/controllers/users/omniauth_callbacks_controller.rb:
