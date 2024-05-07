require "rails_helper"

RSpec.describe GoogleSlidesFacade do
  let(:presentation_id) { "1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc" }
  let(:access_token) {"ya29.a0AXooCgsuIBk8MiqmY-nXtAwhVx8Ic2FH2xv31Gd6SSOlXpShXKTsb8zBGlu_TEkDsAI8Tm4SSe5ynzt5JBdmP0-vFN8DC_l1rMF1vo9uvXqWUBuBBhsQczF2glT47icILLLtrSViY4Z399VCJPZ1_N0y9dqc3j1RtAvLaCgYKAbsSARISFQHGX2Mi7GeOKPl0XrftPmC9X2Gtyw0171"}
  let(:slides_facade) {GoogleSlidesFacade.new({access_token: access_token})}

  describe "#thumbnail_urls" do
    it "returns all the urls for presentation's slides", :vcr do
      urls = slides_facade.thumbnail_urls(presentation_id)
      expect(urls).to be_an(Array)
      expect(urls.count).to eq(5)
    end
  end
end
