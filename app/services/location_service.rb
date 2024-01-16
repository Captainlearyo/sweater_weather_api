class LocationService

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/") do |f|
      f.params[:key] = Rails.application.credentials.mapquest_api[:key]
    end
  end

  def self.get_url(endpoint)
    response = conn.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_coordinates(location)
    #location = "#{city},#{state}"
    get_url("address?key=#{conn.params[:key]}&location=#{(location)}")
  end

  def self.get_travel_time(start_location, end_location)
    conn = Faraday.new(url: 'https://www.mapquestapi.com/directions/v2/route') do |f|
      f.params[:key] = Rails.application.credentials.mapquest_api[:key]
      f.params[:from] = start_location
      f.params[:to] = end_location
      f.params[:routeType] = 'fastest' # Set routeType to 'fastest' to get the fastest route
      f.params[:doReverseGeocode] = false # To avoid reverse geocoding
    end
  
    response = conn.get
    data = JSON.parse(response.body)
  
    if data['route'] && data['route']['formattedTime']
      travel_time = data['route']['formattedTime']
      return travel_time
    else
      return "impossible route"
    end
  end
  
end