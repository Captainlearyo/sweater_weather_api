require 'rails_helper'

RSpec.describe 'API call', :vcr do
    it 'Gets restraurants for a givin city', :vcr do
    
      location = "Dallas,TX"
      term = "Italian"

      json_response = RestaurantService.get_restaurants(location, term)
      # binding.pry
      expect(json_response).to be_a(Hash)
      expect(json_response[:businesses]).to be_an(Array)

      first_business = json_response[:businesses].first
      expect(first_business[:categories].any? { |category| category[:title].casecmp(term).zero? }).to be(true)
    end
end