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
end