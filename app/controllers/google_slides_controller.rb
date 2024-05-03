class GoogleSlidesController < ApplicationController
  def show
    thumbnails = REDIS.get("thumbnails_for_#{params[:drive_id]}")
    @thumbnails = JSON.parse(thumbnails, symbolize_names: true)
  end

  private
end
