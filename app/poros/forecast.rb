class Forecast
  attr_accessor :id, :type, :attributes, :current_weather, :daily_weather, :hourly_weather

  def initialize(forecast_data)
    #puts "Forecast data: #{forecast_data.inspect}"
    @id = nil
    @type = 'forecast'
    @current_weather = {
        last_updated: forecast_data[:current][:last_updated],
        temperature: forecast_data[:current][:temp_f],
        feels_like: forecast_data[:current][:feelslike_f],
        humidity: forecast_data[:current][:humidity],
        uvi: forecast_data[:current][:uv],
        visibility: forecast_data[:current][:vis_miles],
        condition: forecast_data[:current][:condition][:text],
        icon: forecast_data[:current][:condition][:icon]
  }
  if forecast_data[:forecast] && forecast_data[:forecast][:forecastday].is_a?(Array)
    @daily_weather = []
    @hourly_weather = []
  end

    # Fill out daily_weather array if present
    if forecast_data[:forecast] && forecast_data[:forecast][:forecastday].is_a?(Array)
      forecast_data[:forecast][:forecastday].take(5).each do |day|
        daily_weather_attributes = {
          date: day[:date],
          sunrise: day[:astro][:sunrise],
          sunset: day[:astro][:sunset],
          max_temp: day[:day][:maxtemp_f],
          min_temp: day[:day][:mintemp_f],
          condition: day[:day][:condition][:text],
          icon: day[:day][:condition][:icon]
        }
        @daily_weather << daily_weather_attributes
      end
    end

    # Fill out hourly_weather array if present
    if forecast_data[:forecast] && forecast_data[:forecast][:forecastday].is_a?(Array) && forecast_data[:forecast][:forecastday][0][:hour].is_a?(Array)
      forecast_data[:forecast][:forecastday][0][:hour].each do |hour|
        hourly_weather_attributes = {
          time: hour[:time],
          temperature: hour[:temp_f],
          conditions: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }
        @hourly_weather << hourly_weather_attributes
      end
    end
  end
end

