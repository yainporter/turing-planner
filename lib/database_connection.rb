module DatabaseConnection
  def self.store_data(array)
    $hiredis.write(["SET", array.first, array.last])
    $hiredis.write(["GET", array.first])
    $hiredis.read
  end

  def self.events_list(mod)
    date = Time.now.strftime("%d/%m/%Y")
    events = REDIS.get("events_for_#{mod}_#{date}")
    if events
      JSON.parse(events, symbolize_names: true)
    else
      nil
    end
  end

  def self.thumbnails(drive_id)
    urls = REDIS.get("thumbnails_for_#{drive_id}")
    if urls
      JSON.parse(urls, symbolize_names: true)
    else
      nil
    end
  end
end
