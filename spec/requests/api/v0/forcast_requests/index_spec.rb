require 'rails_helper'

RSpec.describe 'Forecast Index', type: :request do 
  it 'Happy Path returns a list data on city forcast', :vcr do

    location = "Dallas,TX"

    get "/api/v0/forecast?location=#{location}"
    
    expect(response).to be_successful

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:data)

    data = json_response[:data]
    expect(data).to be_an(Hash)
    expect(data[:id]).to eq(nil)
    expect(data).to have_key(:type)
    expect(data[:type]).to eq("forecast")
    expect(data).to have_key(:attributes)

    attributes = data[:attributes]
    expect(attributes).to have_key(:type)
    expect(attributes).to have_key(:current_weather)
    expect(attributes).to have_key(:daily_weather)
    expect(attributes).to have_key(:hourly_weather)

    current_weather = attributes[:current_weather]
    expect(current_weather).to have_key(:last_updated)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather).to have_key(:condition)
    expect(current_weather).to have_key(:icon)

    daily_weather = attributes[:daily_weather]
    expect(daily_weather).to be_an(Array)
    expect(daily_weather.first).to have_key(:date)
    expect(daily_weather.first).to have_key(:sunrise)
    expect(daily_weather.first).to have_key(:sunset)
    expect(daily_weather.first).to have_key(:max_temp)
    expect(daily_weather.first).to have_key(:min_temp)
    expect(daily_weather.first).to have_key(:condition)
    expect(daily_weather.first).to have_key(:icon)

    hourly_weather = attributes[:hourly_weather]
    expect(hourly_weather).to be_an(Array)
    expect(hourly_weather.first).to have_key(:time)
    expect(hourly_weather.first).to have_key(:temperature)
    expect(hourly_weather.first).to have_key(:conditions)
    expect(hourly_weather.first).to have_key(:icon)
  end
end