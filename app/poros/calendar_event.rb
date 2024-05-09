class CalendarEvent
  attr_reader :id,
              :start,
              :end,
              :time_zone,
              :summary,
              :html_link,
              :event_description,
              :conference_data,
              :duration

  def initialize(data_hash)
    @id = data_hash[:id]
    @start = format_time(data_hash[:start][:dateTime])
    @end = format_time(data_hash[:end][:dateTime])
    @time_zone = data_hash[:start][:timeZone]
    @summary = data_hash[:summary]
    @html_link = data_hash[:htmlLink]
    @event_description = EventDescription.new(data_hash[:description])
    @duration = @start && @end ? set_duration : nil
    @conference_data = data_hash[:conferenceData] ? ZoomInfo.new(data_hash[:conferenceData]) : nil
  end

  def links_and_text
    @event_description.links_and_text
  end

  def formatted_text
    @event_description.formatted_text
  end

  private

  def format_time(time)
    datetime = DateTime.parse(time)
    time = datetime.strftime("%H:%M")
  end

  def set_duration
      ending = Time.parse(@end)
      starting = Time.parse(@start)
      minutes = (ending - starting) / 60
      "#{minutes.to_i} minutes"
  end
end
