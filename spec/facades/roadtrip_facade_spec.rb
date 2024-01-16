require 'rails_helper'

RSpec.describe 'Roadtrip Facade', :vcr do
  it 'returns trip_data', :vcr do

    start_location = "Dallas,TX"
    end_location = "Austin,TX"
    api_key = "YOUR_API_KEY" 

    json_response = {
      origin: start_location,
      destination: end_location,
      api_key: api_key
    }
  
    trip_data = RoadtripFacade.plan_trip(json_response)

    
    
      
  end
end