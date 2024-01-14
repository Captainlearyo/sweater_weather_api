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

end