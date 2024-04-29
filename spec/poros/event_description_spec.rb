require "rails_helper"

RSpec.describe EventDescription do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end
  describe "initialize" do
    let(:service_data){ GoogleCalendarService.mod1_calendar }
    let (:event_description_data){service_data[:items].first[:description]}

    it "can parse through the description data for important info", :vcr do
      description = EventDescription.new(event_description_data)
    end
  end
end
