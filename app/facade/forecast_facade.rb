class ForecastFacade
  def self.city_forcast(location)
    json_response = LocationService.get_coordinates(location)
    coordinates = json_response[:results][0][:locations][0]
    latitude = coordinates[:latLng][:lat]
    longitude = coordinates[:latLng][:lng]
    forecast = WeatherService.get_forecast_weather(latitude, longitude)
    Forecast.new(forecast)
  end

end