require "rails_helper"

RSpec.describe "Welcome Page" do
  before do
    visit root_path
  end

  describe "nav" do
    it "has a link to Mod 1 demo" do
      expect(page).to have_link("Mod 1")
    end

    it "has a link to Mod 2 demo" do
      expect(page).to have_link("Mod 2")
    end

    it "has a link to Mod 3 demo" do
      expect(page).to have_link("Mod 3")
    end

    it "has a link to Mod 4 demo" do
      expect(page).to have_link("Mod 4")
    end
  end

  describe "demo page 1" do
    it "takes a user to the demo page for a User in Mod 1" do
      save_and_open_page
      click_link("Mod 1")

      expect(page.current_path).to eq(demo_path)
    end
  end
end
