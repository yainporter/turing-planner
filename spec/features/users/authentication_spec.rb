require "rails_helper"

RSpec.describe "Authentication Flow", type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "User Story 1 - " do
    it "", :vcr do
      auth_hash = Faker::Omniauth.google
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(Faker::Omniauth.google)
      require 'pry'; binding.pry
      visit dashboard_path
      require 'pry'; binding.pry
      find(:css,'#google-login')
      find(:css,'#google-login').click

      expect().to eq()
      visit user_google_oauth2_omniauth_authorize_path
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
