require "rails_helper"


RSpec.describe "User Dashboard", type: :feature do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))

    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "dashboard" do
    it "displays a user's agenda for the day" do

      get "/auth/google_oauth2/callback"
      expect(response).to redirect_to(dashboard_path)
      visit dashboard_path
      save_and_open_page
      fill_in("Email", with: "tester@test.test")
      fill_in("Password", with: "testing")
      click_on("Log in")

      expect(page).to have_content("Schedule For the Day")
      expect(page).to have_content("08:30 Accountabilibuddy Check-In")
      expect(page).to have_content("09:00 🎥 Mocks and Stubs")
      expect(page).to have_content("10:30 💬 Project Re-DTR")
      expect(page).to have_content("13:00 💬 Group Project Check In #2")
      expect(page).to have_content("15:00 Work Time")
      expect(page).to have_content("17:30 📚 Homework")
    end
  end

  # How would I test this?
  describe "agenda drop down" do
    xit "collapses with information" do
      expect(page).to have_no_content("Use this time to get to know your Accountabilibuddy. This person should be another resource for you to work through Turing and get help when needed.")

      click_on("08:30 Acountabilibuddy Check-In")

      expect(page).to have_content("Use this time to get to know your Accountabilibuddy. This person should be another resource for you to work through Turing and get help when needed.")
    end
  end
end
