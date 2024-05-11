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
  describe "slides carousel" do
    it "displays images from Google Slides" do

      within("#accordion-nested-collapse-1-2") do
        expect(page).to have_content("Slide show here")
        expect(page).to_not have_content("https://lh7-us.googleusercontent.com/docsdf/AFQj2d71GCS-SigTLrD5WLW7habNAWcqOYShERcwTzSECExmbl0ayn_fj4JGCcVnn9EhJDy_pY7LpZjcEIjw0UFv9sy-ykhhBft3WLinl1zGxXa6sTGSjfsmF9bUZAePO03soAbup8Vw4bq0IBiI_Mb3cKK0sc-cYc3ym0jHH2LQNnKLHRRs=s1600")
        click_button("Slides")
        expect(page).to_not have_content("https://lh7-us.googleusercontent.com/docsdf/AFQj2d71GCS-SigTLrD5WLW7habNAWcqOYShERcwTzSECExmbl0ayn_fj4JGCcVnn9EhJDy_pY7LpZjcEIjw0UFv9sy-ykhhBft3WLinl1zGxXa6sTGSjfsmF9bUZAePO03soAbup8Vw4bq0IBiI_Mb3cKK0sc-cYc3ym0jHH2LQNnKLHRRs=s1600")
      end

      page.find("#accordion-nested-collapse-heading-1-2").click
      click_button("09:00 🎥 Objects, Classes and Instance")

      expect(page).to have_content("LINK")
      expect(page).to have_content("SLIDES")
    end
  end
end
