require "rails_helper"

RSpec.describe GoogleSlidesFacade do
  let(:presentation_id) { "1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc" }
  let(:access_token) {"ya29.a0AXooCguznZeM6hVMQlC4JsQx2fT7q-f5Yc0D5kmhVfK2_5MZ2FE3Ar13WLf8jcePk9Z8R4LMnsrwWTaCxS5_MEn359ibRFhbAxsOayfCgrFZQt3j9CqA3xv1aWpLcKgc1lY_LNZysFSNU4tGb1gq6XKzjNrYJFxtUAlFqgaCgYKARwSARISFQHGX2MieXiHHPvkzXx-nIKVub519Q0173"}
  let(:slides_facade) {GoogleSlidesFacade.new}

  describe "#thumbnail_urls" do
    it "returns all the urls for presentation's slides", :vcr do
      urls = slides_facade.thumbnail_urls(presentation_id)
      expect(urls).to be_an(Array)
      expect(urls.count).to eq(5)

      urls.each do |url|
        expect(url).to include("https://lh7-us.googleusercontent.com")
      end
    end
  end
end
