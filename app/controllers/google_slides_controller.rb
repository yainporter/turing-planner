class GoogleSlidesController < ApplicationController
  def show
    @thumbnails = api_facade.find_thumbnail_url(params[:drive_id])
  end

  private

  def redis_connection
    conn = Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
  end
end
