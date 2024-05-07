require "rails_helper"

RSpec.describe GoogleSlidesFacade do
  let(:presentation_id) { "1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc" }
  let(:access_token) {"ya29.a0AXooCgvcaPNjJdC6y5lYqWfcOxaJUpv3JBoN0MCQrgnuFll0mE6Vn6eSANZNiFhkCq9r1X6csoF-3xJQuxq1f0DHJD3vBRwvvsIZ-OsOf_fDTGt9Ngc3uwcmpPbr-gCYIfl9E8fOGXpQrjFwMAokOw72lwd8TmvGMCiMaCgYKAWcSARISFQHGX2MitOjfTCNR3-p8ZAvzINsMhw0171"}
  let(:slides_facade) {GoogleSlidesFacade.new({access_token: access_token})}

  describe "#thumbnail_urls" do
    it "returns all the urls for presentation's slides", :vcr do
      urls = slides_facade.thumbnail_urls(presentation_id)
      expect(urls).to be_an(Array)
      expect(urls.count).to eq(5)
    end
  end
end
