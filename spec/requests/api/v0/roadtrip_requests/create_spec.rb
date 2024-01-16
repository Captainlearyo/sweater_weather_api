require 'rails_helper'

RSpec.describe "Create roadtrip" do
  it "Happy Path returns roadtrip information with weather data when a valid request is made", :vcr do
    request_body = {
      origin: "Cincinatti,OH",
      destination: "Chicago,IL",
      api_key: "valid_api_key" 
    }

    post '/api/v0/road_trip', params: request_body, as: :json

    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)

  
    expect(json_response).to have_key(:data)
    data = json_response[:data]
    expect(data).to have_key(:id)
    expect(data).to have_key(:type)
    expect(data).to have_key(:attributes)

    attributes = data[:attributes]
    expect(attributes).to have_key(:start_city)
    expect(attributes).to have_key(:end_city)
    expect(attributes).to have_key(:travel_time)
    expect(attributes).to have_key(:weather_at_eta)

  
    expect(attributes[:start_city]).to eq("Cincinatti,OH")
    expect(attributes[:end_city]).to eq("Chicago,IL")
    
    weather_at_eta = attributes[:weather_at_eta]
    expect(weather_at_eta).to have_key(:datetime)
    expect(weather_at_eta).to have_key(:temperature)
    expect(weather_at_eta).to have_key(:condition)
  end

  it "Sad Path returns 401 Unauthorized when an invalid API key is provided", :vcr do
    request_body = {
      origin: "Cincinatti,OH",
      destination: "Chicago,IL",
      api_key: "invalid_api_key" 
    }

    post '/api/v0/road_trip', params: request_body, as: :json

    expect(response).to have_http_status(401)
  end

  it "Sad Path returns 401 Unauthorized when no API key is provided", :vcr do
    request_body = {
      origin: "Cincinatti,OH",
      destination: "Chicago,IL",
      api_key: "" 
    }

    post '/api/v0/road_trip', params: request_body, as: :json

    expect(response).to have_http_status(401)
  end

  it "Sad Path returns impossible route for bad routes", :vcr do
    request_body = {
      origin: "Cincinatti,OH",
      destination: "London, England",
      api_key: "valid_api_key"
    }

    post '/api/v0/road_trip', params: request_body, as: :json

    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)
    #binding.pry
    expect(json_response[:data][:attributes][:travel_time]).to eq("impossible route")

  end
end
