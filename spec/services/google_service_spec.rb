require "rails_helper"

RSpec.describe GoogleService do
  let(:refresh_token){ Rails.application.credentials.dig(:refresh_token) }
  describe "initialize" do
    it "has a refresh token" do
      google_service = GoogleService.new(refresh_token)
      expect(google_service.refresh_token).to exist
    end
  end
end
