require 'rails_helper'

RSpec.describe 'API call', :vcr do
    it 'Gets latatude and longitude for a givin city', :vcr do
    
      # city = "Dallas"
      # state, = "Tx"

      location = "Dallas,TX"

      json_response = LocationService.get_coordinates(location)
      #binding.pry
      expect(json_response).to be_a(Hash)
      expect(json_response[:results]).to be_an(Array)
      expect(json_response[:results].first[:locations]).to be_an(Array)
  
      location = json_response[:results][0][:locations][0]
      expect(location[:latLng]).to be_a(Hash)
  
      latitude = location[:latLng][:lat]
      longitude = location[:latLng][:lng]
  
      expect(latitude).to be_a(Float)
      expect(longitude).to be_a(Float)
    end

    it 'Happy_path get_travel_time for two givin cities', :vcr do
      start_location = "Dallas,TX"
      end_location = "Austin,TX"

      response = LocationService.get_travel_time(start_location, end_location)
      expect(response).to be_a(String)
    end

    it 'Sad_path get_travel_distance for two givin cities', :vcr do
      start_location = "Dallas,TX"
      end_location = "London, England"

      response = LocationService.get_travel_time(start_location, end_location)
      expect(response).to eq("impossible route")
    end
end