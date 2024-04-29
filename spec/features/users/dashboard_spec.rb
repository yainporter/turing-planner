require "rails_helper"

RSpec.describe "User Dashboard", type: :feature do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google',
      uid: '123456',
      info: {
        name: 'John Doe',
        email: 'test@example.com'
      },
      credentials: {
        token: "234lkfnsfk32"
      }
    })

    visit new_user_session_path
    click_on "Login with Google"
  end

  describe "dashboard" do
    it "displays a user's agenda for the day" do
      save_and_open_page
      expect(page).to have_content("Schedule For the Day")
      expect(page).to have_content("08:30 Accountabilibuddy Check-In")
      expect(page).to have_content("09:00 🎥 Mocks and Stubs")
      expect(page).to have_content("10:30 💬 Project Re-DTR")
      expect(page).to have_content("13:00 💬 Group Project Check In #2")
      expect(page).to have_content("15:00 Work Time")
      expect(page).to have_content("17:30 📚 Homework")
    end
  end
end
