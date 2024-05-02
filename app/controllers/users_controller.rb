class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_thumbnail


  def show
    @event_list = conn.read
    @conn = redis_connection
  end

  private
# c556003a6bfedddd98ed4f9663c94bd3
end
