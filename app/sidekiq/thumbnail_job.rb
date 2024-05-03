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
        end
      end
    end
  end

  def thumbnails_missing?(drive_id)
    thumbnails = REDIS.get("thumbnails_for_#{drive_id}")
    if thumbnails
      false
    else
      true
    end
  end
end
