require "rails_helper"

RSpec.describe GoogleCalendarService do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end

  after do
    Timecop.return
  end
  describe ".conn" do
    it "makes a Faraday connection to the Google Calendar API", :vcr do
      connection = GoogleCalendarService.conn
      param_keys = ["key", "timeMin", "timeMax", "singleEvents", "orderBy"]


      expect(connection).to be_a(Faraday::Connection)
      expect(connection.params.keys).to eq(param_keys)
      expect(connection.params[:timeMin]).to eq("2024-04-18T05:00:00-0700")
      expect(connection.params[:timeMax]).to eq("2024-04-18T23:00:00-0700")
    end
  end

  describe ".mod1_calendar" do
    it "returns the parsed json body for the Mod 1 Calendar", :vcr do
      mod1_calendar = GoogleCalendarService.mod1_calendar
      calendar_keys = [
                      :kind,
                      :etag,
                      :summary,
                      :description,
                      :updated,
                      :timeZone,
                      :accessRole,
                      :defaultReminders,
                      :items]
      expect(mod1_calendar).to be_a(Hash)
      expect(mod1_calendar.keys).to eq(calendar_keys)
      expect(mod1_calendar[:summary]).to eq("BEE M1")
      expect(mod1_calendar[:items]).to be_an(Array)
    end
  end

  describe ".mod2_calendar" do
    it "returns the parsed json body for the Mod 2 Calendar", :vcr do
      mod2_calendar = GoogleCalendarService.mod2_calendar
      calendar_keys = [
                      :kind,
                      :etag,
                      :summary,
                      :description,
                      :updated,
                      :timeZone,
                      :accessRole,
                      :defaultReminders,
                      :items]

      expect(mod2_calendar).to be_a(Hash)
      expect(mod2_calendar.keys).to eq(calendar_keys)
      expect(mod2_calendar[:summary]).to eq("BEE M2 Web Applications with Ruby")
      expect(mod2_calendar[:items]).to be_an(Array)
    end
  end

  describe ".mod3_calendar" do
    it "returns the parsed json body for the Mod 3 Calendar", :vcr do
      mod3_calendar = GoogleCalendarService.mod3_calendar
      calendar_keys = [
                      :kind,
                      :etag,
                      :summary,
                      :description,
                      :updated,
                      :timeZone,
                      :accessRole,
                      :defaultReminders,
                      :items]

      expect(mod3_calendar).to be_a(Hash)
      expect(mod3_calendar.keys).to eq(calendar_keys)
      expect(mod3_calendar[:summary]).to eq("BEE M3 Professional Rails Applications")
      expect(mod3_calendar[:items]).to be_an(Array)
    end
  end

  describe ".mod4_calendar" do
    it "returns the parsed json body for the Mod 4 Calendar", :vcr do
      mod4_calendar = GoogleCalendarService.mod4_calendar
      calendar_keys = [
                      :kind,
                      :etag,
                      :summary,
                      :description,
                      :updated,
                      :timeZone,
                      :accessRole,
                      :defaultReminders,
                      :items]

      expect(mod4_calendar).to be_a(Hash)
      expect(mod4_calendar.keys).to eq(calendar_keys)
      expect(mod4_calendar[:summary]).to eq("Mod 4")
      expect(mod4_calendar[:items]).to be_an(Array)
    end
  end

  describe ".community_calendar" do
    it "returns the parsed json body for the Mod 1 Calendar", :vcr do
      community_calendar = GoogleCalendarService.community_calendar
      calendar_keys = [
                      :kind,
                      :etag,
                      :summary,
                      :description,
                      :updated,
                      :timeZone,
                      :accessRole,
                      :defaultReminders,
                      :items]

      expect(community_calendar).to be_a(Hash)
      expect(community_calendar.keys).to eq(calendar_keys)
      expect(community_calendar[:summary]).to eq("Turing Community")
      expect(community_calendar[:items]).to be_an(Array)
    end
  end
end
