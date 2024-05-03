module DatabaseConnection
  def hiredis_conn
    conn ||= Hiredis::Connection.new
    conn.connect("127.0.0.1", 6379)
    conn
  end

  def date
    Time.now.strftime("%d/%m/%Y")
  end

  def store_data(array)
    conn = hiredis_conn
    conn.write(["SET", array.first, array.last])
    conn.write(["GET", array.first])
    conn.read
  end

  def events_list
    events = REDIS.get("events_for_#{date}")
    if events
      JSON.parse(events, symbolize_names: true)
    else
      nil
    end
  end

  def thumbnails
    urls = REDIS.get("thumbnails_for_#{params[:drive_id]}")
    if urls
      JSON.parse(urls, symbolize_names: true)
    else
      nil
    end
  end
end
