require 'rails_helper'

RSpec.describe 'API call', :vcr do
    it 'get_current_weather data for a given latatude and longitude location', :vcr do
      
      lat = 32.7791
      lon = -96.8088
    
      json_response = WeatherService.get_current_weather(lat, lon)
      #binding.pry
      expect(json_response).to be_a(Hash)
      expect(json_response[:location]).to be_a(Hash)
      expect(json_response[:location][:name]).to eq("Dallas")
      expect(json_response[:location][:region]).to eq("Texas")
      expect(json_response[:location][:country]).to eq("United States of America")

      expect(json_response[:current]).to be_a(Hash)
      expect(json_response[:current][:temp_c]).to be_a(Float)
      expect(json_response[:current][:temp_f]).to be_a(Float)
      expect(json_response[:current][:is_day]).to be_in([0, 1])
      expect(json_response[:current][:condition]).to be_a(Hash)
      expect(json_response[:current][:condition][:text]).to be_a(String)
      expect(json_response[:current][:condition][:icon]).to be_a(String)
    end

    it 'get_forecast_weather data for a given latatude and longitude location', :vcr do
      
      lat = 32.7791
      lon = -96.8088
    
      json_response = WeatherService.get_forecast_weather(lat, lon)

      expect(json_response).to be_a(Hash)
      expect(json_response[:location]).to be_a(Hash)
      expect(json_response[:location][:name]).to eq("Dallas")
      expect(json_response[:location][:region]).to eq("Texas")
      expect(json_response[:location][:country]).to eq("United States of America")

      expect(json_response[:current]).to be_a(Hash)
      expect(json_response[:current][:last_updated]).to be_a(String)
      expect(json_response[:current][:temp_f]).to be_a(Float)
      expect(json_response[:current][:feelslike_f]).to be_a(Float)
      expect(json_response[:current][:humidity]).to be_a(Integer)
      expect(json_response[:current][:uv]).to be_a(Float)
      expect(json_response[:current][:vis_miles]).to be_a(Float)
      expect(json_response[:current][:condition]).to be_a(Hash)
      expect(json_response[:current][:condition][:text]).to be_a(String)
      expect(json_response[:current][:condition][:icon]).to be_a(String)

      expect(json_response[:forecast]).to be_a(Hash)
      expect(json_response[:forecast][:forecastday]).to be_an(Array)
      expect(json_response[:forecast][:forecastday].first).to be_a(Hash)
      expect(json_response[:forecast][:forecastday].first[:date]).to be_a(String)
  

      expect(json_response[:forecast][:forecastday]).to be_an(Array)
      expect(json_response[:forecast][:forecastday].first[:hour]).to be_an(Array)
      expect(json_response[:forecast][:forecastday].first[:hour].first).to be_a(Hash)
      expect(json_response[:forecast][:forecastday].first[:hour].first[:time]).to be_a(String)
    end
end