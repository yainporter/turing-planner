class CalendarEvent
  attr_reader :id,
              :start,
              :end,
              :time_zone,
              :summary,
              :html_link,
              :description,
              :conference_data,
              :duration

  def initialize(data_hash)
    @id = data_hash[:id]
    @start = format_time(data_hash[:start][:dateTime])
    @end = format_time(data_hash[:end][:dateTime])
    @time_zone = data_hash[:start][:timeZone]
    @summary = data_hash[:summary]
    @html_link = data_hash[:htmlLink]
    @description = event_descriptions(data_hash[:description])
    @duration = @start && @end ? set_duration : nil
    @conference_data = data_hash[:conferenceData] ? ZoomInfo.new(data_hash[:conferenceData]) : nil
  end

  private

  def event_descriptions(description)
    event_descriptions = EventDescription.new(description)
    {
      links_and_text: event_descriptions.links_and_text,
      formatted_text: event_descriptions.formatted_text
    }
  end

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