require "rails_helper"

RSpec.describe EventDescription do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end

  let(:calendar_service) {GoogleCalendarService.new}

  let(:service_data){ calendar_service.mod1_calendar }
  let (:event_description_data){service_data[:items].first[:description]}
  let (:description){ EventDescription.new(event_description_data) }

  describe "initialize" do
    it "initializes storing @description_data", :vcr do

    end
  end

  describe "#description_resources" do
    xit "returns the links and texts, and drive_id of a document as an array containing a hash", :vcr do
      expect(description.description_resources).to be_an(Array)
      description.description_resources.each do |hash|
        expect(hash).to be_a(Hash)
        expect(hash.keys).to eq([:url, :text, :drive_id])
      end

      expect(description.description_resources.first[:text]).to eq("2403 BE Accountabillibuddies List")
      expect(description.description_resources.first[:text]).to eq("https://docs.google.com/spreadsheets/d/1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA/edit?usp=sharing")
      expect(description.description_resources.first[:drive_id]).to eq("BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA")
    end
  end

  describe "#description_text" do
    it "formats the text from @description_data", :vcr do
      expect(description.formatted_text).to be_a(String)
    end
  end

  describe "#drive_id" do
    it "extracts the drive from the url", :vcr do
      expect(description.drive_id("https://docs.google.com/spreadsheets/d/1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA/edit?usp=sharing")).to eq("1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA")
    end
  end
end
