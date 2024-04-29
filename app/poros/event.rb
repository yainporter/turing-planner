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
    @description = parse_description(data_hash[:description])
    @duration = @start && @end ? set_duration : nil
    @conference_data = data_hash[:conferenceData] ? ZoomInfo.new(data_hash[:conferenceData]) : nil
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

  def parse_description(description_string)
    # User Nokogiri to turn String into a structured format
    doc = Nokogiri::HTML(description_string)

    # Grab all of the text parsed, and join them
    text_outside_links = doc.xpath('//text()').map(&:text).join(' ')
    # Initialize an empty array to store links and their text
    sentences = text_outside_links.split(/[\.\?!]/)
    formatted_text = sentences.map(&:strip).join("\n")
    links_and_text = []

    # Iterate through each link element
    doc.css('a').each do |link|
      # Extract the link URL
      url = link['href']

      # Extract the text inside the link
      text = link.text

      # Add the link URL and text to the array
      links_and_text << { url: url, text: text }
    end

    # Print the extracted links and their text
    links_and_text.each do |link|
      puts "Link URL: #{link[:url]}"
      puts "Link Text: #{link[:text]}"
      puts formatted_text.gsub!(links_and_text.first[:text], '')
    end
  end
end
