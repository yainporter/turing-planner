require "rails_helper"

RSpec.describe Resource do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end
  let(:calendar_service) {GoogleCalendarService.new}

  let(:data){calendar_service.mod1_calendar}
  let(:event1){CalendarEvent.new(data[:items].first)}
  describe "initialize" do
    it "filters data from the Event htmlLink" do

    end
  end
end
