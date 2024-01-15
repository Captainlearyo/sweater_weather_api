require 'rails_helper'

RSpec.describe ForecastSerializer do
  before :each do
    load_test_data
  end
  it "returns the JSON Forecast object within the serializer's format" do
    forecast = Forecast.new(@forecast_data_1)

    serialized_forecast = ForecastSerializer.new(forecast).serializable_hash
    
    expect(serialized_forecast[:data][:id]).to be_nil
    expect(serialized_forecast[:data][:type]).to eq(:forecast)

    attributes = serialized_forecast[:data][:attributes]
    expect(attributes[:type]).to eq("forecast")

    current_weather = attributes[:current_weather]
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather[:humidity]).to be_an(Integer) 
    expect(current_weather[:uvi]).to be_a(Float)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather[:condition]).to be_a(String)
    expect(current_weather[:icon]).to be_a(String)

    daily_weather = attributes[:daily_weather].first
    expect(daily_weather[:date]).to be_a(String)
    expect(daily_weather[:sunrise]).to be_a(String)
    expect(daily_weather[:sunset]).to be_a(String)
    expect(daily_weather[:max_temp]).to be_a(Float)
    expect(daily_weather[:min_temp]).to be_a(Float)
    expect(daily_weather[:condition]).to be_a(String)
    expect(daily_weather[:icon]).to be_a(String)

    hourly_weather = attributes[:hourly_weather].first
    expect(hourly_weather[:time]).to be_a(String)
    expect(hourly_weather[:temperature]).to be_a(Float)
    expect(hourly_weather[:conditions]).to be_a(String)
    expect(hourly_weather[:icon]).to be_a(String)
  end
end
