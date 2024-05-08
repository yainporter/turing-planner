require "rails_helper"

RSpec.describe "Authentication Flow", type: :feature do
  before(:each) do
    # user = FactoryBot.create(:user)
    # login_as(user, :scope => :user)
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(Faker::Omniauth.google)
  end

  it "logs a User in with Google OAuth", :vcr do

    visit new_user_session_path
    find(:css,'#google-login')
    find(:css,'#google-login').click

    expect(current_path).to eq(dashboard_path)
  end
end
