require "rails_helper"

RSpec.describe GoogleCalendarFacade do
  let(:student_mod){ "Mod 1" }
  let(:google_calendar_facade){ GoogleCalendarFacade.new({mod: "Mod 1"}) }

  describe "initialize" do
    it "holds a User's mod", :vcr do
      expect(google_calendar_facade).to be_a(GoogleCalendarFacade)
      expect(google_calendar_facade.mod).to eq(student_mod)
    end
  end

  describe "fltered_calendar_events" do
    it "removes calendar events without a description array", :vcr do
      events = google_calendar_facade.filtered_calendar_events
      events.each do | event |
        expect(event).to be_a CalendarEvent
        expect(event.description).to_not eq(nil)
      end
    end
  end

  # describe "#find_thumbnail_url" do
  #   let(:slides_facade){GoogleCalendarFacade.new({access_token: "ya29.a0Ad52N3_XTssX0q0K53xI8JgVEtndBsHn9i-a5l5VW1T-UBOiMd8FNG1oIfl-5XqBor1Ad-3DD250QfRpjthJWzWUW1x6TQeAs5Ah29VVi98aP3gwHRahwRPkvYkfFOLN6qwqN5lk7zwtSN-5oUdFjMT6n45swGRQDfNqaCgYKAScSARISFQHGX2MiNEtjUg72mTwW7TLlzFczlQ0171"})}

  #   it "finds all the thumbnail ids for a presentation", :vcr do
  #     thumbnail_url = slides_facade.find_thumbnail_url("1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc")
  #     thumbnail_url = slides_facade.find_thumbnail_url("1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc")

  #     expect(thumbnail_url).to be_an(Array)
  #     expect(thumbnail_url.count).to eq(5)

  #     thumbnail_url2 = slides_facade.find_thumbnail_url("1m6y3LsBI_i42mOQ5p1fpFxwBPV1C7bbSEEeHvmT9iSM")
  #     expect(thumbnail_url2.count).to eq(32)
  #   end
  # end
end
