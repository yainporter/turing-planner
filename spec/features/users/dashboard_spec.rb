require "rails_helper"


RSpec.describe "User Dashboard", type: :feature do
  before do
    Timecop.freeze(Time.local(2024, "May", 7))

    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(Faker::Omniauth.google)

    visit dashboard_path
  end

  describe "dashboard" do
    it "displays a user's agenda for the day" do
      expect(page).to have_content("Schedule For the Day")
      expect(page).to have_content("09:00 🎥 Objects, Classes and Instance")
      expect(page).to have_content("11:00 Async: Arrays")
      expect(page).to have_content("13:00 🎥 Intro to Testing")
      expect(page).to have_content("14:30 💬 Work Time")
      expect(page).to have_content("17:30 📚 Homework")
    end
  end

  # How would I test this?
  describe "agenda drop down" do
    it "collapses with information" do
      expect(page).to have_no_content("LINK")
      expect(page).to have_no_content("SLIDES")

      click_on("09:00 🎥 Objects, Classes and Instance")

      save_and_open_page
      expect(page).to have_content("LINK")
      expect(page).to have_content("SLIDES")
    end
  end
end
