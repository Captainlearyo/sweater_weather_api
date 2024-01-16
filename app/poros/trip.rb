class Trip
  attr_accessor :id, :type, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(start_location, end_location, api_key, travel_time, forecast)
    @id = nil
    @type = "roadtrip"
    @start_city = start_location
    @end_city = end_location
    @travel_time = travel_time
    if @travel_time != "impossible route"
      @weather_at_eta = {
          datetime: forecast[:time], 
          temperature: forecast[:temperature],
          condition: forecast[:conditions],
      }
    end
  end
end