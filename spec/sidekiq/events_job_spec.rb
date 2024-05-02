require 'rails_helper'
RSpec.describe EventsJob, type: :job do
  describe "event_summary" do
    it "pulls the id, summary, start time, and index of every event on a calendar day", :vcr do
      expect{EventsJob.perform_async("Mod 1")}.to enqueue_sidekiq_job
    end
  end
end
