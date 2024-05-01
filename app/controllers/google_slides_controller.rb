class GoogleSlidesController < ApplicationController
  def show
    @thumbnails = api_facade.find_thumbnail_url(params[:drive_id])
  end
end
