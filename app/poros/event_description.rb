class EventDescription
  def initialize(description_data)
    @description_data = description_data
  end

  def nokogiri
    Nokogiri::HTML(@description_data)
  end

  def links_and_text
    links_and_text = []
    nokogiri.css('a').each do |link|
      # Extract the link URL, using key value pairs
      url = link['href']

      # Extract the text inside the link
      text = link.text

      # Add the link URL and text to the array
      links_and_text << { url: url, text: text, drive_id: drive_id(url) }
    end
    JSON.parse(links_and_text.to_json, symbolize_names: true)
  end

  def formatted_text
    text_outside_links = nokogiri.xpath('//text()').map(&:text).join("\n")
    links_and_text.each do |link|
      text_outside_links.gsub!(link[:text], '')
    end
    text_outside_links.strip
  end

  def drive_id(url)
    url_parts = url.split('/')
    url_parts[5]
  end
end
