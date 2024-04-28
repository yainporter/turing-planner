class Event
  attr_reader :id, :start, :end, :time_zone, :summary, :html_link, :description, :conference_data, :extended_properties
  def initialize(data_hash)
    @id = data_hash[:id]
    @start = data_hash[:start][:dateTime]
    @end = data_hash[:end][:dateTime]
    @time_zone = data_hash[:start][:timeZone]
    @sunmmary = data_hash[:summary]
    @html_link = data_hash[:htmlLink]
    @description = data_hash[:description]
    @conference_data = data_hash[:conferenceData]
    @extended_properties = data_hash[:extendedProperties]
  end
end
