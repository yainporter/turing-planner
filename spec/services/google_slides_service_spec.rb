require "rails_helper"

RSpec.describe GoogleSlidesService do
  let(:access_token) { "ya29.a0AXooCguznZeM6hVMQlC4JsQx2fT7q-f5Yc0D5kmhVfK2_5MZ2FE3Ar13WLf8jcePk9Z8R4LMnsrwWTaCxS5_MEn359ibRFhbAxsOayfCgrFZQt3j9CqA3xv1aWpLcKgc1lY_LNZysFSNU4tGb1gq6XKzjNrYJFxtUAlFqgaCgYKARwSARISFQHGX2MieXiHHPvkzXx-nIKVub519Q0173" }
  let(:presentation_id) { "1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc" }
  let(:thumbnail_id) {"ge63a4b4_1_0"}
  let(:google_slides) {GoogleSlidesService.new({access_token: access_token})}

  describe "#conn" do
    it "makes a Faraday Connection", :vcr do
      connection = google_slides.conn
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe "get_presentation" do
    it "returns data for a presentation with objectIds", :vcr do
      presentation = google_slides.get_presentation(presentation_id)

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

  describe "get_slide_thumbnail" do
    it "returns the URL for a slide's thumbnail", :vcr do
      url = google_slides.get_slide_thumbnail({presentation_id: presentation_id, thumbnail_id: thumbnail_id})

      expect(url[:contentUrl]).to be_present
    end

    it "will not time out from requests", :vcr do
      #How do you test timeouts from too many requests?
    end
  end

  # describe "refresh_token" do
  #   let(:slides_service){GoogleSlidesService.new({access_token: "ya29.a0Ad52N3-RuV4aXwvnk7QGpUnfPLSA3K8bWcZhidx69eGpnKva4Z1zk3XYEVx2JfcjBpULglJFLPj2yxJGRy3ZR8Pzf9vLPtAZmrDyQy9l-L7uOmkXs5IPBogU0lys1QMjnKV0NJUMiRDc8l_IMRxmDF54OBIxVJJinTT2LwaCgYKAagSARISFQHGX2Mi74INVEgAUrvYbT4sQbI0bg0173", refresh_token: "1//04rARi4kdzjV-CgYIARAAGAQSNwF-L9Ira50DXLdrEMGY694vxf993POm4G7qFa_ZvaI6buDkaFeJSSMnrfgYxQbwjdDqBz3sX2M"})}

  #   it "refreshes a google token", :vcr do
  #     refresh = slides_service.refresh_token
  #     expect(refresh).to eq()
  #   end
  # end
end
