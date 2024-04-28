require "rails_helper"

RSpec.describe GoogleCalendarFacade do
  let(:turing_calendar_id){ "casimircreative.com_59k8msrrc2ddhcv787vubvp0s4" }
  let(:google_calendar_facade){ GoogleCalendarFacade.new(turing_calendar_id) }
  describe "initialize" do
    it "holds a calendar_id", :vcr do
      expect(google_calendar_facade).to be_a(GoogleCalendarFacade)
      expect(google_calendar_facade.calendar_id).to eq(turing_calendar_id)
    end
  end

  describe "create_calendar_events" do
    it "creates an array of events from Service data", :vcr do
      events = google_calendar_facade.create_calendar_events
      events.each do | event |
        expect(event).to be_an Event
      end
    end
  end
end
