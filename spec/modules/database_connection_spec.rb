require "rails_helper"

RSpec.describe DatabaseConnection do
  describe "store_data" do
    it "stores data in a Redis database" do
      mod_array = ["mod", "1"]
      DatabaseConnection.store_data(mod_array)
      require 'pry'; binding.pry
      expect($redis.get("mod")).to eq("1")
    end
  end
end
