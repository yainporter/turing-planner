require "rails_helper"

RSpec.describe ZoomInfo do
  before do
    Timecop.freeze(Time.local(2024, "Apr", 18))
  end

  describe "initialize" do
    let(:calendar_service) {GoogleCalendarService.new}
    let(:service_data){ calendar_service.mod1_calendar }
    let (:zoom_data){service_data[:items].second[:conferenceData]}

    it "initializes correctly", :vcr do
      conference_data = ZoomInfo.new(zoom_data)
      expect(conference_data.type).to eq("video")
      expect(conference_data.meeting_code).to eq("94153040095")
      expect(conference_data.phone_number).to eq("+1 669-444-9171")
      expect(conference_data.notes).to eq("Meeting host: <a href=\"mailto:juliet@turing.edu\" target=\"_blank\">juliet@turing.edu</a><br /><br />Join Zoom Meeting: <br /><a href=\"https://www.google.com/url?q=https://turingschool.zoom.us/j/94153040095&amp;sa=D&amp;source=calendar&amp;usg=AOvVaw3JVl6TngB3_CBqOcy_p3Mx\" target=\"_blank\">https://turingschool.zoom.us/j/94153040095</a>")
    end

    it "initializes without @type" do
      data = { "conferenceData": {
        "entryPoints": [
            {
                "entryPointType": "video",
                "uri": "https://turingschool.zoom.us/j/94153040095",
                "label": "turingschool.zoom.us/j/94153040095",
                "meetingCode": "94153040095"
            },
            {
                "regionCode": "US",
                "entryPointType": "phone",
                "uri": "tel:+16694449171,,94153040095#",
                "label": "+1 669-444-9171"
            },
            {
                "entryPointType": "more",
                "uri": "https://www.google.com/url?q=https://applications.zoom.us/addon/invitation/detail?meetingUuid%3DPkqsXTSRSnCHlCrBduTcNg%253D%253D%26signature%3Dff99bf8e4761059fd0e11978dbf43cf5f2f073821cc50266e442555e889c8128%26v%3D1&sa=D&source=calendar&usg=AOvVaw2BJ8P0D9FHZzZKEeSp9csk"
            }
        ],
        "conferenceSolution": {
            "key": {
                "type": "addOn"
            },
            "name": "Zoom Meeting",
            "iconUri": "https://lh3.googleusercontent.com/pw/AM-JKLUkiyTEgH-6DiQP85RGtd_BORvAuFnS9katNMgwYQBJUTiDh12qtQxMJFWYH2Dj30hNsNUrr-kzKMl7jX-Qd0FR7JmVSx-Fhruf8xTPPI-wdsMYez6WJE7tz7KmqsORKBEnBTiILtMJXuMvphqKdB9X=s128-no"
        },
        "conferenceId": "94153040095",
        "notes": "Meeting host: <a href=\"mailto:juliet@turing.edu\" target=\"_blank\">juliet@turing.edu</a><br /><br />Join Zoom Meeting: <br /><a href=\"https://www.google.com/url?q=https://turingschool.zoom.us/j/94153040095&amp;sa=D&amp;source=calendar&amp;usg=AOvVaw3JVl6TngB3_CBqOcy_p3Mx\" target=\"_blank\">https://turingschool.zoom.us/j/94153040095</a>" }
      }
    end
  end
end
