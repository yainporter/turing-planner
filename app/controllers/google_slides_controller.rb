class GoogleSlidesController < ApplicationController
  def show
    urls = REDIS.get("thumbnails_for_#{params[:drive_id]}")
    @thumbnails = JSON.parse(urls, symbolize_names: true)
  end

  private
end
