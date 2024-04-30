require "rails_helper"

RSpec.describe EventDescription do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end

  let(:service_data){ GoogleCalendarService.mod1_calendar }
  let (:event_description_data){service_data[:items].first[:description]}
  let (:description){ EventDescription.new(event_description_data) }

  describe "initialize" do
    it "initializes storing @description_data", :vcr do

    end
  end

  describe "#links_and_text" do
    xit "returns the links and texts of a document as an array containing a hash", :vcr do
      expect(description.links_and_text).to be_an(Array)
      description.links_and_text.each do |hash|
        expect(hash).to be_a(Hash)
        expect(hash.keys).to eq([:url, :text])
      end
      expect(description.links_and_text.first).to eq({
        text: "2403 BE Accountabillibuddies List",
        url: "https://docs.google.com/spreadsheets/d/1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA/edit?usp=sharing",
        drive_id: "BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA"
        })
    end
  end

  describe "#formatted_text" do
    xit "formats the text from @description_data", :vcr do
      expect(description.formatted_text).to eq("Use this time to get to know your Accountabilibuddy. This person should be another resource for you to work through Turing and get help when needed.
        - What is something about self-care that you could use support with?
        • What have you done lately just for yourself?
        • What would you like to let go of?
        • What are three things that inspire you?
        • What are you most grateful for this week?
        • What thought patterns are holding you back right now?
        • Who is your biggest inspiration?
        • What are you looking forward to doing for yourself this week?
        • What makes a good friend?
        • What makes you feel powerful?
        • If you could go back in time, what advice would you give to your “Week 1” self?
        • What have you felt afraid of recently?
        • How do you know that you feel healthy?
        • What new practice have you started this inning?
        • What do you need to forgive yourself for?
        • What qualities do you think others admire about you?
        • How do you add value to those nearest to you?
        • What do you need more of in your life?
        • What does your ideal morning look like? What does your ideal evening look like?
        • How can you show yourself more love?
        • What have you done lately that you want to brag about?
        • When you wake up in the morning, how do you want to feel?
        • What is one adjustment you’d like to make to your morning routine?
        • When do you feel most confident?
        • What is one adjustment you’d like to make to your nighttime routine?
        • How will you honor your body today?
        • What do you wish you had more time for?
        • What is something about yourself that you learned this week?
        • What is causing you stress right now?")
    end
  end

  describe "#drive_id" do
    it "extracts the drive from the url", :vcr do
      expect(description.drive_id("https://docs.google.com/spreadsheets/d/1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA/edit?usp=sharing")).to eq("1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA")
    end
  end
end
