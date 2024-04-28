require "rails_helper"

RSpec.describe Event do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end

  describe "intialization" do
    let(:data){GoogleCalendarService.mod1_calendar}
    let(:event1){Event.new(data[:items].first)}

    it "has nil value attributes if they are not present", :vcr do
      expect(event1.id).to eq("_60sjacph68sm4bb16or6ab9k6spm2bb2c5ijeb9l6gs3ec9h6kr38oj174_20240418T143000Z")
      expect(event1.html_link).to eq("https://www.google.com/calendar/event?eid=XzYwc2phY3BoNjhzbTRiYjE2b3I2YWI5azZzcG0yYmIyYzVpamViOWw2Z3MzZWM5aDZrcjM4b2oxNzRfMjAyNDA0MThUMTQzMDAwWiBjYXNpbWlyY3JlYXRpdmUuY29tXzU5azhtc3JyYzJkZGhjdjc4N3Z1YnZwMHM0QGc")
      expect(event1.description).to eq("<u></u><u></u><u></u><u></u><u></u><a href=\"https://docs.google.com/spreadsheets/d/1BRRJjDnUiJ3FxmCtwd_dE7deYvym0lM63OOlkYGnVAA/edit?usp=sharing\">2403 BE Accountabillibuddies List</a><br><br>Use this time to get to know your Accountabilibuddy. This person should be another resource for you to work through Turing and get help when needed. <br><br><br>- What is something about self-care that you could use support with?<br>• What have you done lately just for yourself?<br>• What would you like to let go of?<br>• What are three things that inspire you?<br>• What are you most grateful for this week?<br>• What thought patterns are holding you back right now?<br>• Who is your biggest inspiration?<br>• What are you looking forward to doing for yourself this week?<br>• What makes a good friend?<br>• What makes you feel powerful?<br>• If you could go back in time, what advice would you give to your “Week 1” self?<br>• What have you felt afraid of recently?<br>• How do you know that you feel healthy?<br>• What new practice have you started this inning?<br>• What do you need to forgive yourself for?<br>• What qualities do you think others admire about you?<br>• How do you add value to those nearest to you?<br>• What do you need more of in your life?<br>• What does your ideal morning look like? What does your ideal evening look like?<br>• How can you show yourself more love?<br>• What have you done lately that you want to brag about?<br>• When you wake up in the morning, how do you want to feel?<br>• What is one adjustment you’d like to make to your morning routine?<br>• When do you feel most confident?<br>• What is one adjustment you’d like to make to your nighttime routine?<br>• How will you honor your body today?<br>• What do you wish you had more time for?<br>• What is something about yourself that you learned this week?<br>• What is causing you stress right now?<u></u><u></u><u></u><u></u><u></u><u></u>")
      expect(event1.start).to eq("2024-04-18T08:30:00-06:00")
      expect(event1.end).to eq("2024-04-18T09:00:00-06:00")
      expect(event1.time_zone).to eq("America/Denver")
      expect(event1.conference_data).to eq(nil)
      expect(event1.set_duration).to eq("30 minutes")
    end

    let(:event2){Event.new(data[:items].second)}

    it "has a ZoomInfo object if not nil", :vcr do
      expect(event2.conference_data).to be_a(ZoomInfo)
    end
  end
end
