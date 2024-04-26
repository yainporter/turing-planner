require "rails_helper"

RSpec.describe GoogleCalendarService do

  describe ".conn" do
    it "makes a Faraday connection to the Google Calendar API" do
      connection = GoogleCalendarService.conn
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe ".mod_1_calendar" do
    it "returns the body for the Mod 1 Calendar" do
      mod_1_calendar = GoogleCalendarService.mod_1_calendar
      calendar_keys = [
                      :kind,
                      :etag,
                      :summary,
                      :description,
                      :updated,
                      :timeZone,
                      :accessRole,
                      :defaultReminders,
                      :nextPageToken,
                      :items]

      expect(mod_1_calendar).to be_a(Hash)
      expect(mod_1_calendar.keys).to eq(calendar_keys)
    end
  end
end
