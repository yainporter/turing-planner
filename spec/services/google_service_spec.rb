require "rails_helper"

RSpec.describe GoogleService do
  let(:refresh_token){ Rails.application.credentials.dig(:refresh_token) }
  describe "refresh_token" do
    it "gets a new refresh token", :vcr do
      google_service = GoogleService.new(refresh_token)
      response = google_service.refresh_access_token

      expect(response.status).to eq(200)

      response_keys = [:access_token, :expires_in, :scope, :token_type, :id_token]

      expect(response.body.keys).to eq(response_keys)
    end
  end
end
