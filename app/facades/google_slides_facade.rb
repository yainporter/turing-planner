class GoogleSlidesFacade
  def initialize(presentation_id)
    @service = GoogleSlidesService
    @presentation_id = presentation_id
  end

  def slide_ids
    @service.get_presentation
  end
end
