require "rails_helper"

RSpec.describe Event do
  before(:each) do

  end

  describe "intialization" do
    it "creates events", :vcr do
      data = GoogleCalendarService.mod1_calendar
      events = data[:items].map do |event|
                  Event.new(event)
                end

    end
  end
end
