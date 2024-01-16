class RoadtripFacade
  def self.plan_trip(json_response)
    start_location = json_response[:origin]
    end_location = json_response[:destination]
    api_key = json_response[:api_key]

    travel_time = LocationService.get_travel_time(start_location, end_location)
    if travel_time != "impossible route"
      hours, minutes, seconds = travel_time.split(':').map(&:to_i)
      total_hours = hours + (minutes / 60.0) + (seconds / 3600.0)
      rounded_hours = total_hours.ceil
    end

    json_response = LocationService.get_coordinates(end_location)
    coordinates = json_response[:results][0][:locations][0]
    latitude = coordinates[:latLng][:lat]
    longitude = coordinates[:latLng][:lng]
    forecast_data = WeatherService.get_forecast_weather(latitude, longitude)
    forecast = Forecast.new(forecast_data)
    if travel_time != "impossible route"
      weather_at_end_location = forecast.hourly_weather[rounded_hours - 1]
    end
    trip = Trip.new(start_location, end_location, api_key, travel_time, weather_at_end_location)

  end

end