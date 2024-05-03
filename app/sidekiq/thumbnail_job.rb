class ThumbnailJob
  include Sidekiq::Job
  include HiredisConnection

  def perform(access_token)
    conn = HiredisConnection.conn
    date = Time.now.strftime("%d/%m/%Y")
    events = REDIS.get("events_for_#{date}")
    event_list = JSON.parse(events, symbolize_names: true)
    event_list.map do |event|
      event[:description][:links_and_text].map do |link_and_text|
        if link_and_text[:url].include?("https://docs.google.com/presentation")
          slides_facade = GoogleSlidesFacade.new({access_token: access_token})
          links = slides_facade.thumbnail_urls(link_and_text[:drive_id])
          links = links.to_json
          conn.write(["SET", "thumbnails_for_#{link_and_text[:drive_id]}", links ])
          conn.write(["GET", "thumbnails_for_#{link_and_text[:drive_id]}"])
          conn.read
        end
      end
    end
  end
end
