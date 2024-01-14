class WeatherService

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1/") do |f|
      f.params[:key] = Rails.application.credentials.weather_api[:key]
    end
  end

  def self.get_url(endpoint)
    response = conn.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end


  # def self.get_current_weather(lat, lon)
  #   q ="#{lat},#{lon}"
  #   get_url("current.json?q=#{(q)}")
  # end

  def self.get_forecast_weather(lat, lon)
    q ="#{lat},#{lon}"
    get_url("forecast.json?q=#{(q)}")
  end
end