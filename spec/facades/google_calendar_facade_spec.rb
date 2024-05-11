require "rails_helper"

RSpec.describe GoogleCalendarFacade do
  let(:google_calendar_facade){ GoogleCalendarFacade.new }

  describe "initialize" do
    it "holds a User's mod", :vcr do
      expect(google_calendar_facade).to be_a(GoogleCalendarFacade)
    end
  end

  describe "create_all_calendar_events" do
    it "gets the Calendar data for all Turing Calendars", :vcr do
      calendar_events = google_calendar_facade.create_all_calendar_events

      expect(calendar_events).to be_a(Hash)
      
      calendar_event_keys = [:"Community Calendar", :"Mod 1", :"Mod 2", :"Mod 3", :"Mod 4"]

      expect(calendar_events.keys).to eq(calendar_event_keys)
      expect(calendar_events[:"Community Calendar"]).to be_an(Array)
      expect(calendar_events[:"Mod 1"]).to be_an(Array)
      expect(calendar_events[:"Mod 2"]).to be_an(Array)
      expect(calendar_events[:"Mod 3"]).to be_an(Array)
      expect(calendar_events[:"Mod 4"]).to be_an(Array)

      calendar_events.each do |student_mod, calendar_events|
        calendar_events.each do |event|
          expect(event).to be_a(CalendarEvent)
        end
      end
    end
  end
end
