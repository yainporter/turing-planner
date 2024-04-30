class Event
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

  ### How do I test this?
  def parse_description(description_string)
    # Use Nokogiri to turn String into a structured format
    doc = Nokogiri::HTML(description_string)

    # Grab all of the text parsed, return only the text and join them into a big String with a newline
    text_outside_links = doc.xpath('//text()').map(&:text).join("\n")

    # Initialize an empty array to store links and their text
    links_and_text = []

    # Iterate through each link element
    doc.css('a').each do |link|
      # Extract the link URL, using key value pairs
      url = link['href']

      # Extract the text inside the link
      text = link.text

      # Add the link URL and text to the array
      links_and_text << { url: url, text: text }
    end

    # Print the extracted links and their text
    links_and_text.each do |link|
      text_outside_links.gsub!(link[:text], '')
    end
    formatted_text = text_outside_links.strip

    {
      links_and_text: links_and_text,
      formatted_text: formatted_text
    }
  end
end
