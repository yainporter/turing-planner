class ZoomInfo
  attr_reader :type, :link, :meeting_code, :phone_number, :notes

  def initialize(zoom_data)
    @type = zoom_data[:entryPoints].first[:entryPointType]
    @link = zoom_data[:entryPoints].first[:uri]
    @meeting_code = zoom_data[:entryPoints].first[:meetingCode]
    @phone_number = zoom_data[:entryPoints].second[:label]
    @notes = zoom_data[:notes]
  end

  # Is it better to use this method to get the @type? Or Should I continue with .first, .second, etc?
  def zoom_type
    zoom_data[:entryPoints].map do |type|
      @type = type[:entryPointType]
    end
  end
end
