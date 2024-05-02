require "rails_helper"

RSpec.describe GoogleSlidesService do
  let(:access_token) { "ya29.a0AXooCgu5g-mXlJhMIj_npDFo0EYJ6WWdtz463KFl_UmpgpMEp5wh0vOPdkotKjQZsnPtGtVrdpYa0m3E8TzL9xg8RgkSl-jrRR0f1y5P2QKfrCIFxicXUzIP8XVzM1dUWD6toVhmm6Vot6xfPo3jpXvTFRUAAuIrKv1naCgYKAQUSARISFQHGX2MiISg8KWAqYvQrw42-8pXlxw0171" }
  let(:presentation_id) { "1EAYk18WDjIG-zp_0vLm3CsfQh_i8eXc67Jo2O9C6Vuc" }
  let(:thumbnail_id) {"ge63a4b4_1_0"}
  let(:google_slides) {GoogleSlidesService.new({access_token: access_token, presentation_id: presentation_id})}

  describe "#conn" do
    it "makes a Faraday Connection", :vcr do
      connection = google_slides.conn
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe "get_presentation" do
    it "returns data for a presentation with objectIds", :vcr do
      presentation = google_slides.get_presentation

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
      url = google_slides.get_slide_thumbnail(thumbnail_id)

      expect(url[:contentUrl]).to be_present
    end

    it "will not time out from requests", :vcr do
      #How do you test timeouts from too many requests?
      presentation_id1 = "1J55751_ZSPJMqQW-Fse1EFTRkjAWOvWmaNjgXev-9GQ"
      presentation_id2= "1m6y3LsBI_i42mOQ5p1fpFxwBPV1C7bbSEEeHvmT9iSM"

      google_slides = GoogleSlidesService.new({access_token: access_token, presentation_id: presentation_id1})
      presentation1 = google_slides.get_presentation
      thumbnail_ids1 = presentation1[:slides].map do |slide|
        slide[:objectId]
      end

      expect(thumbnail_ids1.count).to eq(39)

      urls1 =  thumbnail_ids1.map do |thumbnail_id|
                google_slides.get_slide_thumbnail(thumbnail_id)
              end

      expect(urls1.count).to eq(39)

      google_slides = GoogleSlidesService.new({access_token: access_token, presentation_id: presentation_id2})
      presentation2 = google_slides.get_presentation
      thumbnail_ids2 = presentation2[:slides].map do |slide|
        slide[:objectId]
      end

      expect(thumbnail_ids2.count).to eq(32)

      urls2 =  thumbnail_ids2.map do |thumbnail_id|
        google_slides.get_slide_thumbnail(thumbnail_id)
      end

      expect(urls2.count).to eq(32)
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
