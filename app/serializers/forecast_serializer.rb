class ForecastSerializer
  include JSONAPI::Serializer
  attributes :type, :current_weather, :daily_weather, :hourly_weather
end
