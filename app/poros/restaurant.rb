class Restaurant
  attr_accessor :id, :type, :attributes, :destination_city, :forecast, :restaurant

  def initialize(location, restraurant, condition, temperature)
    #puts "Forecast data: #{forecast_data.inspect}"
    @id = nil
    @type = "munchie"
    @destination_city = location
    @forecast = {
        summary: condition,
        temperature: temperature.to_i
    }
    @restaurant =  {
        name: restraurant[:name],
        address: restraurant[:location][:address1],
        rating: restraurant[:rating],
        reviews: restraurant[:review_count]
  }
  end
end