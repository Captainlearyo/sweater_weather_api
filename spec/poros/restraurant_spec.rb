require 'rails_helper'

RSpec.describe 'Restaurant Poro', :vcr do
  it 'initializes with correct attributes', :vcr do

    location = "Dallas,TX"
    food = "Italian"

    json_response = LocationService.get_coordinates(location)
    coordinates = json_response[:results][0][:locations][0]
    latitude = coordinates[:latLng][:lat]
    longitude = coordinates[:latLng][:lng]
    forecast = WeatherService.get_current_weather(latitude, longitude)
    weather = Forecast.new(forecast)
    restraurants = RestaurantService.get_restaurants(location, food)
    restraurant = restraurants[:businesses].first

    restaurant = Restaurant.new(location, restraurant, weather.current_weather[:condition], weather.current_weather[:temperature])
    #binding.pry
    expect(restaurant).to be_a(Restaurant)
    expect(restaurant.destination_city).to be_a(String)
    expect(restaurant.forecast).to be_a(Hash)

    forecast_attributes = restaurant.forecast
    expect(forecast_attributes[:summary]).to be_a(String)
    expect(forecast_attributes[:temperature]).to be_a(Integer)

    restaurant_attributes = restaurant.restaurant
    expect(restaurant_attributes[:name]).to be_a(String)
    expect(restaurant_attributes[:address]).to be_a(String)
    expect(restaurant_attributes[:rating]).to be_a(Float)
    expect(restaurant_attributes[:reviews]).to be_a(Integer)

    
  end
end