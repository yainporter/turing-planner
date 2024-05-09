require "rails_helper"

RSpec.describe CalendarEvent do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end
  let(:calendar_service) {GoogleCalendarService.new}
  let(:data){calendar_service.mod1_calendar}
  let(:event1){CalendarEvent.new(data[:items].first)}

  describe "intialization" do
    it "has nil value attributes if they are not present", :vcr do
      expect(event1.id).to eq("_60sjacph68sm4bb16or6ab9k6spm2bb2c5ijeb9l6gs3ec9h6kr38oj174_20240418T143000Z")
      expect(event1.event_link).to eq("https://www.google.com/calendar/event?eid=XzYwc2phY3BoNjhzbTRiYjE2b3I2YWI5azZzcG0yYmIyYzVpamViOWw2Z3MzZWM5aDZrcjM4b2oxNzRfMjAyNDA0MThUMTQzMDAwWiBjYXNpbWlyY3JlYXRpdmUuY29tXzU5azhtc3JyYzJkZGhjdjc4N3Z1YnZwMHM0QGc")
      expect(event1.summary).to eq("Accountabilibuddy Check-In")
      expect(event1.start).to eq("08:30")
      expect(event1.end).to eq("09:00")
      expect(event1.time_zone).to eq("America/Denver")
      expect(event1.conference_data).to eq(nil)
      expect(event1.duration).to eq("30 minutes")
    end

    let(:event2){CalendarEvent.new(data[:items].second)}

    it "has a ZoomInfo object if not nil", :vcr do
      expect(event2.conference_data).to be_a(ZoomInfo)
    end

    it "has a @description that is a Hash", :vcr do
      expect(event1.description).to be_a(Hash)
    end
  end
end
