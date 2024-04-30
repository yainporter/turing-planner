require "rails_helper"

RSpec.describe GoogleSlidesService do
  let(:access_token) { "ya29.a0Ad52N39aJuCOQF73zRkNzHVHBWjbgKi8-AmfvLCcHo7C9ZnUnM7xQKt06N95Aets-mSq8woRIepUNTjTbIhCkK4y-41eEGyYhk6_CPG4fT-Wz_3yTsMpzQjOkvb94FWbCbX-23PTUkEGjnJrsWJQiXiRfHUdWrG0gArAaCgYKAS4SARISFQHGX2MiSr8ZOAK08fjvulU5DCKRZA0171" }
  let(:google_slides) {GoogleSlidesService.new(access_token)}
  describe "#conn" do
    it "makes a Faraday Connection", :vcr do
      connection = google_slides.conn
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe "get_presentation" do
    it "returns data for a presentation with objectIds", :vcr do
      presentation = google_slides.get_presentation("1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc")

      presentation_keys = [
        :presentationId,
        :pageSize,
        :slides,
        :title,
        :masters,
        :layouts,
        :locale,
        :notesMaster
      ]
      expect(presentation).to be_a(Hash)
      expect(presentation[:presentationId]).to eq("1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc")
      expect(presentation.keys).to eq(presentation_keys)
    end
  end
end
