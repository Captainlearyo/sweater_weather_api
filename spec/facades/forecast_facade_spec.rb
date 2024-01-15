require 'rails_helper'

RSpec.describe 'Forcast Facade', :vcr do
  it 'should give city_forcast data when given city and state' do
    location = "Dallas,TX"

    result = ForecastFacade.city_forcast(location)
    
    expect(result).to be_a(Forecast)
    expect(result.current_weather[:last_updated]).to be_a(String)


    

    expect(result.daily_weather).to be_an(Array)
    expect(result.daily_weather.first[:date]).to be_a(String)
    

    expect(result.hourly_weather).to be_an(Array)
    expect(result.hourly_weather.first[:time]).to be_a(String)
    
      
  end

  it 'should give current_forcast data when given city and state' do
    location = "Dallas,TX"

    result = ForecastFacade.current_forcast(location)
    
    expect(result).to be_a(Forecast)
    expect(result.current_weather[:last_updated]).to be_a(String)


    

    expect(result.daily_weather).to be_nil
    expect(result.hourly_weather).to be_nil

    
      
  end
end