require "rails_helper"

RSpec.describe GoogleService do
  let(:refresh_token){ Rails.application.credentials.dig(:refresh_token) }
  describe "refresh_token" do
    it "gets a new refresh token", :vcr do
      google_service = GoogleService.new(refresh_token)
      new_token = google_service.refresh_access_token
      require 'pry'; binding.pry
    end
  end
end
