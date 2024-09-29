# require "rails_helper"

# RSpec.describe DatabaseConnection do
  # describe "store_data" do
  #   it "stores data in a Redis database" do
  #     mod_array = ["mod", "1"]
  #     DatabaseConnection.store_data(mod_array)
  #     expect($redis.get("mod")).to eq("1")
  #   end
  # end

  # describe "events_list" do
  #   it "retrieves the list of events stored, and parses it into json format", :vcr do
  #     events = Hash.new
  #     calendar_facade = GoogleCalendarFacade.new

  #     all_calendar_events = calendar_facade.create_all_calendar_events
  #     all_calendar_events.each do |mod, calendar_events|
  #       events[mod] = calendar_events.map.with_index(1) do |event, index|
  #           {
  #             id: event.id,
  #             summary: event.summary,
  #             start: event.start,
  #             links_and_text: event.links_and_text,
  #             formatted_text: event.formatted_text,
  #             index: index
  #           }
  #       end
  #     end

  #     class EventsToday
  #       include DatabaseConnection
  #       def store_info(events)
  #         date = Time.now.strftime("%d/%m/%Y")
  #         events.each do |mod, calendar_events|
  #           DatabaseConnection.store_data(["events_for_#{mod.to_s}_#{date}", calendar_events.to_json])
  #         end
  #       end
  #     end

  #     events_today = EventsToday.new
  #     events_today.store_info(events)

  #     expect(DatabaseConnection.events_list("Mod 1")).to eq()


  #   end
  # end
# end
