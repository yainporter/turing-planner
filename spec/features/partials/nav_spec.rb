require "rails_helper"

RSpec.describe "Nav Partial", type: :feature do

  describe "Navbar links when NOT logged in" do
    before do
      visit "/"
    end

    it "does not display any link besides Log In when a User is not logged in" do
      within("nav") do
        expect(page).to have_link("Log In")
        expect(page).to_not have_link("Dashboard")
        expect(page).to_not have_link("GitHub")
        expect(page).to_not have_link("Slack")
        expect(page).to_not have_link("Calendar")
      end
    end

    it "has a working log in link" do
      expect(page.current_path).to eq(root_path)
      click_on("Log In")
      expect(page.current_path).to eq(new_user_session_path)
    end
  end
end
