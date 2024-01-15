class RestaurantService

  def self.conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses/search") do |f|
      f.headers['Authorization'] = "Bearer #{Rails.application.credentials.yelp_api[:key]}"
    end
  end

  def self.get_url(params)
    response = conn.get("", params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_restaurants(location, term)
    params = {
      location: location,
      term: term,
    }

    get_url(params)
  end
end

