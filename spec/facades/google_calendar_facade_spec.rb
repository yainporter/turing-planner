require "rails_helper"

RSpec.describe GoogleCalendarFacade do
  let(:student_mod){ "Mod 1" }
  let(:google_calendar_facade){ GoogleCalendarFacade.new("Mod 1") }

  describe "initialize" do
    it "holds a User's mod", :vcr do
      expect(google_calendar_facade).to be_a(GoogleCalendarFacade)
      expect(google_calendar_facade.mod).to eq(student_mod)
    end
  end

  describe "create_calendar_events" do
    it "creates an array of events from Service data based on a User's Mod", :vcr do
      events = google_calendar_facade.create_calendar_events
      events.each do | event |
        expect(event).to be_an Event
        expect(event.mod).to eq()
      end
    end
  end
end
