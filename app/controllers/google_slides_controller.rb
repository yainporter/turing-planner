class GoogleSlidesController < ApplicationController
  before_action :set_drive_id

  def show
    require 'pry'; binding.pry
    thumbnails = REDIS.get("thumbnails_for_#{params[:drive_id]}")
    @thumbnails = JSON.parse(thumbnails, symbolize_names: true)
  end

  private

  def set_drive_id
    session[:drive_id] ||= params[:drive_id]
  end
end
