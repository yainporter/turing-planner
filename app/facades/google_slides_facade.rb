class GoogleSlidesFacade
  def initialize
    @slides_service = GoogleSlidesService.new
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
# drive_id =  "1LYnfW7kY9wtBxF3PO5iruc7B4Qkuy5NE948dps21gFE"
