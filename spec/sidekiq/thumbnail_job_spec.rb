require 'rails_helper'
RSpec.describe ThumbnailJob, type: :job do
  describe "event_summary" do
    it "pulls the id, summary, start time, and index of every event on a calendar day", :vcr do
      thumbnail_job = ThumbnailJob.new
      events = thumbnail_job.event_summary("Mod 1")

      expect(ThumbnailJob).to eq()
      expect(events).to be_an(Array)
      expect(events.count).to eq(6)

      event_keys = [:id, :summary, :start, :index]

      events.each do |event|
        expect(event.keys).to eq(event_keys)
      end
    end
  end
end
