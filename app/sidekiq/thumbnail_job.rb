class ThumbnailJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform(calendar)
    slides_facade = GoogleSlidesFacade.new
    today = Time.now.strftime("%d/%m/%Y")
    events_list = JSON.parse($redis.get("events_for_#{calendar}_#{today}"))
    events_list.each do |event|
      event["links_and_text"].each do |link_and_text|
        url = link_and_text["url"]
        drive_id = link_and_text["drive_id"]
        google_presentation_url = "https://docs.google.com/presentation"

        if url.include?(google_presentation_url) && thumbnails_missing?(drive_id)
          links = slides_facade.thumbnail_urls(drive_id).to_json
          $redis.set("thumbnails_for_#{link_and_text[:drive_id]}", links)
        end
      end
    end
  end

  private

  # def slides_service
  #   slides_service = GoogleSlidesService.new
  # end

  # def access_token
  #   google_auth = GoogleOAuthService.new
  #   google_auth.refresh_access_token
  # end

  def thumbnails_missing?(drive_id)
    if  $redis.get("thumbnails_for_#{drive_id}")
      false
    else
      true
    end
  end
end
