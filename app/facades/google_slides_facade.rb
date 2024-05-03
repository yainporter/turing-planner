class GoogleSlidesFacade
  def initialize(hash)
    @slides_service =  GoogleSlidesService.new({
      access_token: hash[:access_token],
      refresh_token: hash[:refresh_token]
    })
  end

  def thumbnail_urls(presentation_id)
    presentation = @slides_service.get_presentation(presentation_id)
    slides = presentation[:slides]
    urls = slides.map do |slide|
      slide_id = slide[:objectId]
      thumbnail_data = @slides_service.get_slide_thumbnail({presentation_id: presentation_id, thumbnail_id: slide_id})
      thumbnail_data[:contentUrl]
    end
    urls
  end
end
