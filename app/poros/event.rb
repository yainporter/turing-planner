class Event
  def initialize(data_hash)
    @id = data_hash[:id]
    @start = data_hash[:start][:dateTime]
  end
end
