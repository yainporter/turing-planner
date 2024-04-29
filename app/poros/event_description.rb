class EventDescription
  def initialize(description_data)
    @description_data = Nokogiri::HTML(description_data)
  end

  def links_and_text
    links_and_text = []
    @description_data.css('a').each do |link|
      # Extract the link URL, using key value pairs
      url = link['href']

      # Extract the text inside the link
      text = link.text

      # Add the link URL and text to the array
      links_and_text << { url: url, text: text }
    end
    JSON.parse(links_and_text.to_json, symbolize_names: true)
  end

  def formatted_text
    text_outside_links = @description_data.xpath('//text()').map(&:text).join("\n")
    links_and_text.each do |link|
      text_outside_links.gsub!(link[:text], '')
    end
    text_outside_links.strip
  end
end
