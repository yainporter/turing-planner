class GoogleSlidesController < ApplicationController
  def show
    @conn = redis_connection
    @events 
  end

  private

  def redis_connection
    conn = Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
  end
end
