require "rails_helper"

RSpec.describe GoogleSlidesFacade do
  let(:presentation_id) { "1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc" }
  let(:access_token) {"ya29.a0AXooCgtsuItfp6kt0Tm7RmcXTWHv_w2dFxAleHQ-3AsUec1ezj_3nlSdJaSzZgE8tTfhyC36u8-Ft7j4XXLiuWPN11pSmannLeRprqjgp3GyB4Uh9Zf6rcPiE4hCgW9vB48gQSrHcwzeC7ETQJYnGNiNkkGYDPRgU3dLaCgYKAZgSARISFQHGX2MiXn8OMTDd8gKE7xelkZW6qA0171"}
  let(:slides_facade) {GoogleSlidesFacade.new({access_token: access_token, presentation_id: presentation_id})}

  describe "#thumbnail_urls" do
    it "returns all the urls for presentation's slides", :vcr do
      urls = slides_facade.thumbnail_urls
      expect(urls).to be_an(Array)
      expect(urls.count).to eq(5)
    end
  end
end
