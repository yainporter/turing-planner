class GoogleSlidesFacade
  def initialize(hash)
    @slides_service =  GoogleSlidesService.new({
      access_token: hash[:access_token],
      presentation_id: hash[:presentation_id],
      refresh_token: hash[:refresh_token]
    })
  end

  def thumbnail_urls
    presentation = @slides_service.get_presentation
    slides = presentation[:slides]
    urls = slides.map do |slide|
      slide_id = slide[:objectId]
      @slides_service.get_slide_thumbnail(slide_id)[:contentUrl]
    end
    urls
  end
end
