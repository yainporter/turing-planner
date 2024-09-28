module DatabaseConnection
  def self.store_data(array)
    $redis.set(array[0], array[1])
  end

  def self.store_events_today(events, date)
    events.each do |mod, calendar_events|
      self.store_data(["events_for_#{mod.to_s}_#{date}", calendar_events.to_json])
    end
  end

  def self.events_list_today(mod)
    date = Time.now.strftime("%d/%m/%Y")
    events = $redis.get("events_for_#{mod}_#{date}")
    if events
      JSON.parse(events, symbolize_names: true)
    else
      nil
    end
  end

  def self.thumbnails(drive_id)
    urls = $redis.get("thumbnails_for_#{drive_id}")
    if urls
      JSON.parse(urls, symbolize_names: true)
    else
      nil
    end
  end
end
