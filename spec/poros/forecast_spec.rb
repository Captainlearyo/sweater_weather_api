require 'rails_helper'

RSpec.describe 'Forecast Poro' do
  before :each do
    load_test_data
  end
  it 'initializes with correct attributes' do

    forecast = Forecast.new(@forecast_data_1)

    #binding.pry

    expect(forecast.id).to be_nil
    expect(forecast.type).to eq('forecast')

    # Check attributes within current_weather
    current_weather = forecast.current_weather
    expect(current_weather).to be_a(Hash)
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather[:uvi]).to be_a(Float)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather[:condition]).to be_a(String)
    expect(current_weather[:icon]).to be_a(String)

    # Check attributes within daily_weather
    daily_weather = forecast.daily_weather
    expect(daily_weather).to be_an(Array)
    expect(daily_weather).to_not be_empty

    # Check attributes within hourly_weather
    hourly_weather = forecast.hourly_weather
    expect(hourly_weather).to be_an(Array)
    expect(hourly_weather).to_not be_empty
  end
end