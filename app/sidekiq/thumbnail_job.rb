class ThumbnailJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform(access_token)
    events_list.map do |event|
      event[:description][:links_and_text].map do |link_and_text|
        if link_and_text[:url].include?("https://docs.google.com/presentation") && thumbnails_missing?(link_and_text[:drive_id])
          slides_facade = GoogleSlidesFacade.new({access_token: access_token})
          links = slides_facade.thumbnail_urls(link_and_text[:drive_id])
          links = links.to_json

          store_data(["thumbnails_for_#{link_and_text[:drive_id]}", links])
          ActionCable.server.broadcast('notifications', { status: 'completed'})
        end
      end
    end
  end

  private

  def thumbnails_missing?(drive_id)
    if thumbnails(drive_id)
      false
    else
      true
    end
  end
end
