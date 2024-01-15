class MunchiesFacade
  def self.destination_data(location, food)
    json_response = LocationService.get_coordinates(location)
    coordinates = json_response[:results][0][:locations][0]
    latitude = coordinates[:latLng][:lat]
    longitude = coordinates[:latLng][:lng]
    forecast = WeatherService.get_current_weather(latitude, longitude)
    weather = Forecast.new(forecast)
    restraurants = RestaurantService.get_restaurants(location, food)
    restraurant = restraurants[:businesses].first
    Restaurant.new(location, restraurant, weather.current_weather[:condition], weather.current_weather[:temperature])  end

end